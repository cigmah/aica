port module Main exposing (..)

{-| AICA: An Interactive Case Archive

Online medical cases with active interaction in the form of a (limited) chatbot.

-}

import Array exposing (Array)
import Array.Extra
import Browser
import Cases.Case as Case exposing (..)
import Cases.List
import Diagnosis exposing (..)
import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Interaction exposing (..)
import Investigations.Investigation as Investigation exposing (Investigation)
import Json.Decode as Decode exposing (Decoder, Value)
import Json.Encode as Encode
import Markdown
import Medication exposing (Medication)
import Option
import Prescription exposing (Prescription)
import Questions.Question as Question exposing (Question)
import Set exposing (Set)
import Styles exposing (..)
import Time exposing (Posix)



---- MODEL ----


type alias CaseStartData =
    { patient : Case }


caseStartDataInit : Case -> CaseStartData
caseStartDataInit patient =
    { patient = patient }


type alias CaseInteractData =
    { patient : Case
    , interaction : Interaction
    , responseQueue : List Response
    , startTime : Maybe Posix
    , currentTime : Maybe Posix
    , currentSearch : String
    , filteredOptions : List (Option.Data Question Msg)
    , currentSelected : Maybe (Option.Data Question Msg)
    }


{-| Maximum time for a case interaction in milliseconds.
-}
caseMaxTime =
    4 * 60 * 1000


{-| Frequency of tick response in milliseconds
-}
tickResponseFrequency =
    250


caseInteractDataInit : Case -> CaseInteractData
caseInteractDataInit patient =
    { patient = patient
    , interaction = Interaction.init patient
    , responseQueue = Interaction.initResponseQueue patient
    , startTime = Nothing
    , currentTime = Nothing
    , currentSearch = ""
    , filteredOptions = []
    , currentSelected = Nothing
    }


type PrescriptionModal
    = PrescriptionModalHidden
    | PrescriptionModalVisible Prescription


type alias CaseFinishData =
    { patient : Case
    , interaction : Interaction
    , note : String
    , diagnosisSearch : String
    , filteredDiagnoses : List (Option.Data Diagnosis Msg)
    , chosenDiagnosis : Maybe Diagnosis
    , investigationSearch : String
    , filteredInvestigations : List (Option.Data Investigation Msg)
    , chosenInvestigations : Array Investigation
    , medicationSearch : String
    , filteredMedications : List (Option.Data Medication Msg)
    , currentMedication : Maybe Medication
    , prescriptionDose : String
    , prescriptionRoute : String
    , prescriptionFreq : String
    , chosenPrescriptions : Array Prescription
    }


caseFinishDataInit : CaseInteractData -> CaseFinishData
caseFinishDataInit data =
    { patient = data.patient
    , interaction = data.interaction
    , note = ""
    , diagnosisSearch = ""
    , filteredDiagnoses = []
    , chosenDiagnosis = Nothing
    , investigationSearch = ""
    , filteredInvestigations = []
    , chosenInvestigations = Array.empty
    , medicationSearch = ""
    , filteredMedications = []
    , currentMedication = Nothing
    , prescriptionDose = ""
    , prescriptionRoute = ""
    , prescriptionFreq = ""
    , chosenPrescriptions = Array.empty
    }


type alias CaseFeedbackData =
    { patient : Case
    , interaction : Interaction
    , note : String
    , diagnosis : Maybe Diagnosis
    , investigations : List Investigation
    , prescriptions : List Prescription
    , exemplarInvestigationIntSet : Set Int
    , exemplarPrescriptionIntSet : Set Int
    }


caseFeedbackDataInit : CaseFinishData -> CaseFeedbackData
caseFeedbackDataInit data =
    { patient = data.patient
    , interaction = data.interaction
    , note = data.note
    , diagnosis = data.chosenDiagnosis
    , investigations = data.chosenInvestigations |> Array.toList
    , prescriptions = data.chosenPrescriptions |> Array.toList
    , exemplarInvestigationIntSet = data.patient.exemplarInvestigations |> List.map Investigation.toInt |> Set.fromList
    , exemplarPrescriptionIntSet = data.patient.exemplarPrescriptions |> List.map (.medication >> Medication.toInt) |> Set.fromList
    }


type alias ScreenStartData =
    List Case.Details


type Screen
    = ScreenStart ScreenStartData
    | ScreenCaseStart CaseStartData
    | ScreenCaseInteract CaseInteractData
    | ScreenCaseFinish CaseFinishData
    | ScreenCaseFeedback CaseFeedbackData


type alias Model =
    { screen : Screen
    , flags : Flags
    }


updateScreen : Model -> Screen -> Model
updateScreen model screen =
    { model | screen = screen }


type alias Flags =
    { logo : String
    , profiles : Dict String String
    , storage : Storage
    }


type alias Storage =
    { completed : Set String }


port cache : Value -> Cmd msg


encodeStorage : Storage -> Value
encodeStorage storage =
    Encode.object
        [ ( "completed", storage.completed |> Set.toList |> Encode.list Encode.string ) ]


storageDecoder : Decoder Storage
storageDecoder =
    Decode.map Storage
        (Decode.field "completed" (Decode.list Decode.string |> Decode.map Set.fromList))


profileDecoder : Decoder ( String, String )
profileDecoder =
    Decode.map2 (\x y -> ( x, y ))
        (Decode.field "id" Decode.string)
        (Decode.field "path" Decode.string)


decoderFlags : Decoder Flags
decoderFlags =
    Decode.map3 Flags
        (Decode.field "logo" Decode.string)
        (Decode.field "profiles" (Decode.list profileDecoder |> Decode.map Dict.fromList))
        (Decode.field "storage" storageDecoder)


defaultFlags =
    { logo = ""
    , profiles = Dict.empty
    , storage = { completed = Set.empty }
    }


init : Value -> ( Model, Cmd Msg )
init rawValue =
    case Decode.decodeValue decoderFlags rawValue of
        Ok flags ->
            ( { screen = ScreenStart Cases.List.basicList
              , flags = flags
              }
            , Cmd.none
            )

        Err _ ->
            ( { screen = ScreenStart Cases.List.basicList
              , flags = defaultFlags
              }
            , Cmd.none
            )



---- UPDATE ----


type Msg
    = NoOp
    | ClickedPatient String
    | ClickedGoHome
    | ClickedAssessPatient Case
    | ChangedCurrentSearch String
    | ClickedQuestion Question String
    | TickResponse Posix
    | TickTimer Posix
    | ClickedFinishInteraction
    | ChangedNote String
    | ChangedDiagnosisSearch String
    | ClickedDiagnosis Diagnosis String
    | ClickedDeleteDiagnosis
    | ChangedInvestigationSearch String
    | ClickedInvestigation Investigation String
    | ClickedDeleteInvestigation Int
    | ChangedMedicationSearch String
    | ClickedMedication Medication String
    | ChangedDose String
    | ChangedRoute String
    | ChangedFreq String
    | ClickedAddPrescription
    | ClickedDeletePrescription Int
    | ClickedFinishNote


withCmd : Cmd Msg -> Model -> ( Model, Cmd Msg )
withCmd cmd model =
    ( model, cmd )


oneOrNone : List a -> Maybe a
oneOrNone list =
    case list of
        [ item ] ->
            Just item

        _ ->
            Nothing


findCase : String -> Maybe Case
findCase id =
    Cases.List.list
        |> List.filter (\patient -> patient.details.id == id)
        |> oneOrNone


validQuestion : String -> Option.Data Question Msg -> Bool
validQuestion filter data =
    let
        loweredFilter =
            String.toLower filter

        loweredString =
            String.toLower data.string
    in
    String.contains loweredFilter loweredString
        || String.contains loweredFilter data.tags


questionOptions =
    Question.optionList ClickedQuestion


processSearch : String -> CaseInteractData -> Screen
processSearch filter data =
    if String.length filter >= minTypeLength then
        let
            filteredOptions =
                questionOptions
                    |> List.filter (validQuestion filter)
        in
        { data | currentSearch = filter, filteredOptions = filteredOptions }
            |> ScreenCaseInteract

    else
        { data | currentSearch = filter, filteredOptions = [] }
            |> ScreenCaseInteract


{-| Minimium number of characters to type before filtering questions.
-}
minTypeLength =
    3


addResponseToEndOfQueue : CaseInteractData -> Response -> CaseInteractData
addResponseToEndOfQueue ({ responseQueue } as data) response =
    { data | responseQueue = responseQueue ++ [ response ] }


replaceFirstInResponseQueue : CaseInteractData -> Response -> CaseInteractData
replaceFirstInResponseQueue ({ responseQueue } as data) response =
    case responseQueue of
        head :: rest ->
            { data | responseQueue = response :: rest }

        _ ->
            data


consTo : List a -> a -> List a
consTo list item =
    item :: list


updateCaseFinishNote : CaseFinishData -> String -> CaseFinishData
updateCaseFinishNote data string =
    { data | note = string }


validOption : String -> Option.Data a Msg -> Bool
validOption string option =
    String.contains string (String.toLower option.string)


diagnosisOptions =
    Diagnosis.optionList ClickedDiagnosis


investigationOptions =
    Investigation.optionList ClickedInvestigation


medicationOptions =
    Medication.optionList ClickedMedication


updateCaseFinishDiagnosisSearch : CaseFinishData -> String -> CaseFinishData
updateCaseFinishDiagnosisSearch data string =
    if String.length string > 0 then
        let
            filtered =
                diagnosisOptions
                    |> List.filter (validOption (String.toLower string))
        in
        { data | diagnosisSearch = string, filteredDiagnoses = filtered }

    else
        { data | diagnosisSearch = string, filteredDiagnoses = [] }


updateCaseFinishInvestigationSearch : CaseFinishData -> String -> CaseFinishData
updateCaseFinishInvestigationSearch data string =
    if String.length string > 0 then
        let
            filtered =
                investigationOptions
                    |> List.filter (validOption (String.toLower string))
        in
        { data | investigationSearch = string, filteredInvestigations = filtered }

    else
        { data | investigationSearch = string, filteredInvestigations = [] }


updateCaseFinishMedicationSearch : CaseFinishData -> String -> CaseFinishData
updateCaseFinishMedicationSearch data string =
    if String.length string > 0 then
        let
            filtered =
                medicationOptions
                    |> List.filter (validOption (String.toLower string))
        in
        { data | medicationSearch = string, filteredMedications = filtered }

    else
        { data | medicationSearch = string, filteredMedications = [] }


updateChosenDiagnosis : CaseFinishData -> Maybe Diagnosis -> CaseFinishData
updateChosenDiagnosis data maybeDiagnosis =
    case maybeDiagnosis of
        Just diagnosis ->
            { data | chosenDiagnosis = maybeDiagnosis, diagnosisSearch = "", filteredDiagnoses = [] }

        Nothing ->
            { data | chosenDiagnosis = maybeDiagnosis }


updateChosenInvestigations : CaseFinishData -> Investigation -> CaseFinishData
updateChosenInvestigations data investigation =
    { data
        | chosenInvestigations = Array.push investigation data.chosenInvestigations
        , investigationSearch = ""
        , filteredInvestigations = []
    }


updateChosenMedication : CaseFinishData -> Medication -> CaseFinishData
updateChosenMedication data medication =
    { data
        | currentMedication = Just medication
        , medicationSearch = ""
        , filteredMedications = []
    }


updateDose : CaseFinishData -> String -> CaseFinishData
updateDose data dose =
    { data | prescriptionDose = dose }


updateRoute : CaseFinishData -> String -> CaseFinishData
updateRoute data route =
    { data | prescriptionRoute = route }


updateFreq : CaseFinishData -> String -> CaseFinishData
updateFreq data freq =
    { data | prescriptionFreq = freq }


deleteChosenInvestigation : CaseFinishData -> Int -> CaseFinishData
deleteChosenInvestigation data index =
    { data | chosenInvestigations = Array.Extra.removeAt index data.chosenInvestigations }


updateChosenPrescriptions : CaseFinishData -> Medication -> CaseFinishData
updateChosenPrescriptions data medication =
    let
        newPrescription =
            { medication = medication
            , dosage = data.prescriptionDose
            , route = data.prescriptionRoute
            , frequency = data.prescriptionFreq
            }
    in
    { data
        | chosenPrescriptions = Array.push newPrescription data.chosenPrescriptions
        , currentMedication = Nothing
        , prescriptionDose = ""
        , prescriptionRoute = ""
        , prescriptionFreq = ""
    }


deleteChosenPrescription : CaseFinishData -> Int -> CaseFinishData
deleteChosenPrescription data index =
    { data | chosenPrescriptions = Array.Extra.removeAt index data.chosenPrescriptions }


updateStorage : Case -> Storage -> Storage
updateStorage patient storage =
    { storage | completed = Set.insert patient.details.id storage.completed }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model
                |> withCmd Cmd.none

        ClickedPatient id ->
            case findCase id of
                Nothing ->
                    model
                        |> withCmd Cmd.none

                Just patient ->
                    ScreenCaseStart (caseStartDataInit patient)
                        |> updateScreen model
                        |> withCmd Cmd.none

        ClickedGoHome ->
            ScreenStart Cases.List.basicList
                |> updateScreen model
                |> withCmd Cmd.none

        ClickedAssessPatient patient ->
            ScreenCaseInteract (caseInteractDataInit patient)
                |> updateScreen model
                |> withCmd Cmd.none

        ChangedCurrentSearch string ->
            case model.screen of
                ScreenCaseInteract data ->
                    processSearch string data
                        |> updateScreen model
                        |> withCmd Cmd.none

                _ ->
                    model |> withCmd Cmd.none

        ClickedQuestion question string ->
            case model.screen of
                ScreenCaseInteract data ->
                    let
                        questionId =
                            Question.toInt question

                        newData =
                            { data | interaction = Interaction.addQuestionToInteraction data.interaction string, currentSearch = "" }
                    in
                    data.patient.script questionId
                        |> Interaction.createQueueItem string
                        |> addResponseToEndOfQueue newData
                        |> ScreenCaseInteract
                        |> updateScreen model
                        |> withCmd Cmd.none

                _ ->
                    model |> withCmd Cmd.none

        TickResponse posix ->
            case model.screen of
                ScreenCaseInteract data ->
                    case data.responseQueue of
                        response :: rest ->
                            if response.readDelay > 0 then
                                response
                                    |> Interaction.reduceReadDelay tickResponseFrequency
                                    |> replaceFirstInResponseQueue data
                                    |> ScreenCaseInteract
                                    |> updateScreen model
                                    |> withCmd Cmd.none

                            else if response.writeDelay > 0 then
                                response
                                    |> Interaction.reduceWriteDelay tickResponseFrequency
                                    |> replaceFirstInResponseQueue data
                                    |> ScreenCaseInteract
                                    |> updateScreen model
                                    |> withCmd Cmd.none

                            else
                                { data
                                    | interaction = Interaction.addResponseToInteraction data.interaction response
                                    , responseQueue = rest
                                }
                                    |> ScreenCaseInteract
                                    |> updateScreen model
                                    |> withCmd Cmd.none

                        [] ->
                            model |> withCmd Cmd.none

                _ ->
                    model |> withCmd Cmd.none

        -- Ticks every second
        TickTimer posix ->
            case model.screen of
                ScreenCaseInteract data ->
                    case data.startTime of
                        Nothing ->
                            { data | startTime = Just posix, currentTime = Just posix }
                                |> ScreenCaseInteract
                                |> updateScreen model
                                |> withCmd Cmd.none

                        Just startTime ->
                            let
                                diff =
                                    Time.posixToMillis posix - Time.posixToMillis startTime
                            in
                            if diff > caseMaxTime then
                                caseFinishDataInit data
                                    |> ScreenCaseFinish
                                    |> updateScreen model
                                    |> withCmd Cmd.none

                            else
                                { data | currentTime = Just posix }
                                    |> ScreenCaseInteract
                                    |> updateScreen model
                                    |> withCmd Cmd.none

                _ ->
                    model |> withCmd Cmd.none

        ClickedFinishInteraction ->
            case model.screen of
                ScreenCaseInteract data ->
                    caseFinishDataInit data
                        |> ScreenCaseFinish
                        |> updateScreen model
                        |> withCmd Cmd.none

                _ ->
                    model |> withCmd Cmd.none

        ChangedNote string ->
            case model.screen of
                ScreenCaseFinish data ->
                    string
                        |> updateCaseFinishNote data
                        |> ScreenCaseFinish
                        |> updateScreen model
                        |> withCmd Cmd.none

                _ ->
                    model |> withCmd Cmd.none

        ChangedDiagnosisSearch string ->
            case model.screen of
                ScreenCaseFinish data ->
                    string
                        |> updateCaseFinishDiagnosisSearch data
                        |> ScreenCaseFinish
                        |> updateScreen model
                        |> withCmd Cmd.none

                _ ->
                    model |> withCmd Cmd.none

        ClickedDiagnosis diagnosis _ ->
            case model.screen of
                ScreenCaseFinish data ->
                    Just diagnosis
                        |> updateChosenDiagnosis data
                        |> ScreenCaseFinish
                        |> updateScreen model
                        |> withCmd Cmd.none

                _ ->
                    model |> withCmd Cmd.none

        ClickedDeleteDiagnosis ->
            case model.screen of
                ScreenCaseFinish data ->
                    Nothing
                        |> updateChosenDiagnosis data
                        |> ScreenCaseFinish
                        |> updateScreen model
                        |> withCmd Cmd.none

                _ ->
                    model |> withCmd Cmd.none

        ChangedInvestigationSearch string ->
            case model.screen of
                ScreenCaseFinish data ->
                    string
                        |> updateCaseFinishInvestigationSearch data
                        |> ScreenCaseFinish
                        |> updateScreen model
                        |> withCmd Cmd.none

                _ ->
                    model |> withCmd Cmd.none

        ClickedInvestigation investigation _ ->
            case model.screen of
                ScreenCaseFinish data ->
                    investigation
                        |> updateChosenInvestigations data
                        |> ScreenCaseFinish
                        |> updateScreen model
                        |> withCmd Cmd.none

                _ ->
                    model |> withCmd Cmd.none

        ClickedDeleteInvestigation index ->
            case model.screen of
                ScreenCaseFinish data ->
                    index
                        |> deleteChosenInvestigation data
                        |> ScreenCaseFinish
                        |> updateScreen model
                        |> withCmd Cmd.none

                _ ->
                    model |> withCmd Cmd.none

        ChangedMedicationSearch string ->
            case model.screen of
                ScreenCaseFinish data ->
                    string
                        |> updateCaseFinishMedicationSearch data
                        |> ScreenCaseFinish
                        |> updateScreen model
                        |> withCmd Cmd.none

                _ ->
                    model |> withCmd Cmd.none

        ClickedMedication medication _ ->
            case model.screen of
                ScreenCaseFinish data ->
                    medication
                        |> updateChosenMedication data
                        |> ScreenCaseFinish
                        |> updateScreen model
                        |> withCmd Cmd.none

                _ ->
                    model |> withCmd Cmd.none

        ChangedDose string ->
            case model.screen of
                ScreenCaseFinish data ->
                    string
                        |> updateDose data
                        |> ScreenCaseFinish
                        |> updateScreen model
                        |> withCmd Cmd.none

                _ ->
                    model |> withCmd Cmd.none

        ChangedRoute string ->
            case model.screen of
                ScreenCaseFinish data ->
                    string
                        |> updateRoute data
                        |> ScreenCaseFinish
                        |> updateScreen model
                        |> withCmd Cmd.none

                _ ->
                    model |> withCmd Cmd.none

        ChangedFreq string ->
            case model.screen of
                ScreenCaseFinish data ->
                    string
                        |> updateFreq data
                        |> ScreenCaseFinish
                        |> updateScreen model
                        |> withCmd Cmd.none

                _ ->
                    model |> withCmd Cmd.none

        ClickedAddPrescription ->
            case model.screen of
                ScreenCaseFinish data ->
                    case data.currentMedication of
                        Nothing ->
                            model |> withCmd Cmd.none

                        Just medication ->
                            medication
                                |> updateChosenPrescriptions data
                                |> ScreenCaseFinish
                                |> updateScreen model
                                |> withCmd Cmd.none

                _ ->
                    model |> withCmd Cmd.none

        ClickedDeletePrescription index ->
            case model.screen of
                ScreenCaseFinish data ->
                    index
                        |> deleteChosenPrescription data
                        |> ScreenCaseFinish
                        |> updateScreen model
                        |> withCmd Cmd.none

                _ ->
                    model |> withCmd Cmd.none

        ClickedFinishNote ->
            case model.screen of
                ScreenCaseFinish data ->
                    let
                        newStorage =
                            model.flags.storage
                                |> updateStorage data.patient

                        oldFlags =
                            model.flags

                        newFlags =
                            { oldFlags | storage = newStorage }

                        newModel =
                            { model | flags = newFlags }
                    in
                    data
                        |> caseFeedbackDataInit
                        |> ScreenCaseFeedback
                        |> updateScreen newModel
                        |> withCmd (cache (encodeStorage newStorage))

                _ ->
                    model |> withCmd Cmd.none



---- VIEW ----


markdown attributes =
    Markdown.toHtmlWith
        { githubFlavored = Just { tables = True, breaks = False }
        , defaultHighlighting = Nothing
        , sanitize = True
        , smartypants = False
        }
        attributes


genderToString : Gender -> String
genderToString gender =
    case gender of
        Female ->
            "F"

        Male ->
            "M"

        Other s ->
            s


patientAgeGender : Case.Details -> String
patientAgeGender patient =
    String.fromInt patient.age ++ genderToString patient.gender


viewHeader : Html Msg
viewHeader =
    article [ tailwind "m-2 px-4 py-2 rounded border bg-gray-800 text-white flex w-full font-bold" ]
        [ div [ tailwind "flex w-2/5" ]
            [ text "Sim Patient Name" ]
        , div [ tailwind "w-1/5" ]
            [ text "Age" ]
        , div [ tailwind "w-1/5" ]
            [ text "Gender" ]
        , div [ tailwind "w-1/5" ]
            [ text "Occupation" ]
        ]


viewBasicItem : Set String -> Dict String String -> Case.Details -> Html Msg
viewBasicItem completed profiles patient =
    let
        profileImg =
            profiles
                |> Dict.get patient.id
                |> Maybe.withDefault ""

        isCompleted =
            Set.member patient.id completed
    in
    article
        [ tailwind "m-4 group cursor-pointer hover:shadow-lg border border-gray-200 rounded h-48 w-48 relative trans-all overflow-hidden active:shadow-inner"
        , onClick (ClickedPatient patient.id)
        ]
        [ img
            [ src profileImg
            , tailwind "absolute pt-2 p-4"
            , classList [ ( "opacity-25", isCompleted ) ]
            ]
            []
        , section
            [ tailwind "absolute top-0 px-2 py-1 text-sm bg-black text-white font-bold w-full text-center"
            , classList [ ( "hidden", not isCompleted ) ]
            ]
            [ div [] [ text "COMPLETED" ] ]
        , section
            [ tailwind "absolute bottom-0 px-2 py-1 text-sm border-t border-gray-200 bg-white group-hover:bg-black group-hover:text-white w-full trans-all rounded-b-lg"
            ]
            [ h1 [ tailwind "font-bold mt-0" ] [ text (patient.firstName ++ " " ++ patient.lastName) ]
            , div [ tailwind "flex between text-xs" ]
                [ h2 [ tailwind "mr-2 mt-0" ] [ text (patientAgeGender patient) ]
                , h3 [ tailwind "mt-0" ] [ text patient.occupation ]
                ]
            ]
        ]


viewScreenStart : Model -> ScreenStartData -> Html Msg
viewScreenStart model patients =
    section [ tailwind "fade-in" ]
        [ section [ tailwind "lg:hidden h-screen w-full bg-white p-4 flex flex-col items-center justify-center" ]
            [ img [ src model.flags.logo, tailwind "w-1/2 md:w-1/3 m-8" ] []
            , h1 [ tailwind "text-lg text-center w-2/3 md:w-1/2" ]
                [ span [ tailwind "font-bold" ] [ text "AICA " ]
                , text "is designed for desktop use. For your mobile revision needs, try our question bank, "
                , a [ href "https://aorta.cigmah.org", tailwind "underline font-bold" ] [ text "AORTA" ]
                , text "."
                ]
            ]
        , section [ tailwind "h-screen w-full bg-white hidden lg:flex" ]
            [ section [ tailwind "w-1/3 p-8 flex flex-col items-center justify-center shadow-inner" ]
                [ img [ src model.flags.logo, tailwind "w-1/2 mb-16" ] []
                , section [ tailwind "w-3/4 mb-8" ]
                    [ h1 [ tailwind "text-5xl" ] [ text "AICA" ]
                    , p [ tailwind "" ]
                        [ span [ tailwind "font-bold" ] [ text "AICA" ]
                        , text " is "
                        , span [ tailwind "font-bold" ] [ text "An Interactive Case Archive" ]
                        , text ". Click on a patient on the right hand side to start an interactive case. You will learn about the patient by collecting information from a history and examination, then will assess and manage their presenting complaint."
                        ]
                    ]
                ]
            , section [ tailwind "w-2/3 p-8" ]
                [ section [ tailwind "bg-white h-full w-full overflow-auto rounded" ]
                    [ div [ tailwind "p-4 flex flex-wrap" ]
                        (List.map (viewBasicItem model.flags.storage.completed model.flags.profiles) patients)
                    ]
                ]
            ]
        ]


viewScreenCaseStart : Model -> CaseStartData -> Html Msg
viewScreenCaseStart model data =
    let
        profileImg =
            model.flags.profiles
                |> Dict.get data.patient.details.id
                |> Maybe.withDefault ""
    in
    section [ tailwind "flex bg-white w-screen h-screen" ]
        [ section [ tailwind "p-8 flex flex-col w-1/3 items-center fade-in shadow-inner justify-center pb-24" ]
            [ div [ tailwind "bg-white w-1/2 mb-8 rounded-b-none rounded" ] [ img [ tailwind "w-full", src profileImg ] [] ]
            , div [ tailwind "bg-white rounded rounded-t-none text-xl w-full xl:w-3/4 mb-8 justify-center items-center flex flex-col" ]
                [ h1 [ tailwind "font-bold" ] [ text (data.patient.details.firstName ++ " " ++ data.patient.details.lastName) ]
                , div [ tailwind "flex" ]
                    [ h2 [ tailwind "mr-4 mt-0" ] [ text (patientAgeGender data.patient.details) ]
                    , h3 [ tailwind "mt-0" ] [ text data.patient.details.occupation ]
                    ]
                ]
            , button
                [ onClick ClickedGoHome
                , tailwind "w-full xl:w-3/4 cursor-pointer p-2 border-l-8 border-gray-400 text-gray-700 shadow hover:shadow-lg active:shadow-inner trans-all mb-2 text-lg"
                ]
                [ text "Go Back" ]
            , button
                [ onClick (ClickedAssessPatient data.patient)
                , tailwind "w-full xl:w-3/4 cursor-pointer p-2 border-l-8 border-olive-600 shadow hover:shadow-lg active:shadow-inner trans-all text-lg"
                ]
                [ text "Assess Patient" ]
            , div
                [ tailwind "mt-8 text-sm text-gray-700" ]
                [ div [] [ text ("Case written by " ++ data.patient.details.writer) ]
                , div [] [ text ("Case illustrated by " ++ data.patient.details.illustrator) ]
                ]
            ]
        , section [ tailwind "bg-white rounded-lg w-2/3 p-16 fade-in overflow-auto" ]
            [ markdown [ class "markdown pb-32 max-w-900 m-auto" ] data.patient.stem
            ]
        ]


isTypingText : CaseInteractData -> String
isTypingText data =
    case data.responseQueue of
        response :: tail ->
            if (response.readDelay <= 0) && (response.writeDelay > 0) then
                data.patient.details.firstName ++ " is typing..."

            else
                ""

        _ ->
            ""


viewConversationItem : Interaction.Item -> Html Msg
viewConversationItem item =
    article
        [ tailwind "w-full flex pt-3"
        , classList
            [ ( "justify-start", isYou item.speaker )
            , ( "justify-end", isMe item.speaker )
            ]
        ]
        [ div
            [ tailwind "px-4 py-2"
            , classList
                [ ( "bg-gray-200 text-gray-700 rounded-r-lg rounded-tl-lg", isYou item.speaker )
                , ( "bg-olive-600 text-white rounded-l-lg rounded-tr-lg", isMe item.speaker )
                ]
            ]
            [ text item.value ]
        ]


viewScreenCaseInteract : Model -> CaseInteractData -> Html Msg
viewScreenCaseInteract model data =
    section [ tailwind "flex bg-white w-screen h-screen" ]
        [ section [ tailwind "flex flex-col p-8 w-1/3 items-center shadow-inner" ]
            [ section [ tailwind "text-sm text-gray-600 mb-2 w-full" ]
                [ div [ tailwind "w-full" ]
                    [ viewTimer data ]
                ]
            , input
                [ type_ "text"
                , value data.currentSearch
                , onInput ChangedCurrentSearch
                , tailwind "w-full font-bold bg-white shadow-inner text-lg px-3 py-2 focus:border-olive-500 border-b-2 trans-all border-gray-300 bg-gray-100 focus:bg-white"
                ]
                []
            , section [ tailwind "mt-4 w-full overflow-auto mb-4 h-full" ] [ viewFilteredQuestions data ]
            , button
                [ onClick ClickedFinishInteraction
                , tailwind "bg-white border-l-4 border-gray-400 trans-all p-2 w-full cursor-pointer hover:shadow-lg shadow active:shadow-inner"
                ]
                [ text "Finish Interaction" ]
            ]
        , section [ tailwind "bg-white rounded-lg shadow w-2/3 p-8 pt-4 flex flex-col" ]
            [ section [ tailwind "text-sm text-gray-500 w-full border-b border-gray-300 text-center bg-white h-12 flex justify-center items-center" ]
                [ text (isTypingText data) ]
            , section [ tailwind "flex flex-col-reverse overflow-hidden pl-8 pr-8 pb-8" ]
                (List.map viewConversationItem data.interaction.conversation)
            ]
        ]


viewFilteredQuestions : CaseInteractData -> Html Msg
viewFilteredQuestions data =
    if String.length data.currentSearch >= minTypeLength then
        if List.length data.filteredOptions > 0 then
            div []
                (List.map viewFilteredOption data.filteredOptions)

        else
            div [ tailwind "text-gray-600" ]
                [ text "There no questions matching what you've typed. We suggest typing one word indicating broadly what you'd like to know, such as 'when' or 'where', a symptom like 'fever' or 'rash', or parts to examine such as 'heart' or 'power'!" ]

    else
        div [ tailwind "text-gray-600 text-sm" ]
            [ text "Type in at least 4 characters to search possible questions you can ask or examination findings you can check, such as 'job', 'dyspnoea', or 'auscultate'." ]


viewFilteredOption : Option.Data Question Msg -> Html Msg
viewFilteredOption data =
    button
        [ tailwind "mb-2 w-full text-left shadow p-3 border-l-4 border-white hover:border-black hover:font-bold hover:shadow-lg cursor-pointer focus:border-olive-500 active:shadow-inner trans-all"
        , onClick data.onClick
        ]
        [ text data.string ]


{-| Left-pad an integer with a zero if below 10, otherwise leave as is. Only for positive numbers.
-}
padTwoChar : Int -> String
padTwoChar int =
    if int < 10 then
        "0" ++ String.fromInt int

    else
        String.fromInt int


viewSecondsAsString : Int -> String
viewSecondsAsString seconds =
    let
        minutes =
            seconds // 60

        remainder =
            seconds |> modBy 60
    in
    String.join ":" [ padTwoChar minutes, padTwoChar remainder ]


viewTimer : CaseInteractData -> Html Msg
viewTimer data =
    case ( data.currentTime, data.startTime ) of
        ( Just now, Just before ) ->
            let
                timeInSeconds =
                    (caseMaxTime - (Time.posixToMillis now - Time.posixToMillis before)) // 1000
            in
            article
                []
                [ text "Time remaining: "
                , span [ classList [ ( "text-red-500 font-bold", timeInSeconds < 10 ) ] ] [ text (viewSecondsAsString timeInSeconds) ]
                ]

        _ ->
            article
                []
                [ text "Loading timer..." ]


viewOption : Option.Data a Msg -> Html Msg
viewOption option =
    button [ onClick option.onClick, tailwind "text-left p-1 hover:bg-olive-600 hover:text-white px-2 py-1 text-sm" ]
        [ text option.string ]


viewDiagnosisOptions : CaseFinishData -> Html Msg
viewDiagnosisOptions data =
    case data.filteredDiagnoses of
        [] ->
            div [] []

        diagnoses ->
            section [ tailwind "absolute bg-white flex flex-col h-64 z-50 w-full shadow-lg overflow-auto border-gray-300 border-l border-r border-b" ]
                (List.map viewOption diagnoses)


viewDiagnosisSearch : Model -> CaseFinishData -> Html Msg
viewDiagnosisSearch model data =
    case data.chosenDiagnosis of
        Nothing ->
            section [ tailwind "w-full relative" ]
                [ input
                    [ tailwind "text-sm p-2 shadow-inner w-full mt-2 border-b-2 border-gray-400 focus:border-olive-500 bg-gray-100 focus:bg-white"
                    , placeholder "Search for a diagnosis here."
                    , onInput ChangedDiagnosisSearch
                    , value data.diagnosisSearch
                    ]
                    []
                , viewDiagnosisOptions data
                ]

        Just diagnosis ->
            article [ tailwind "w-full mt-2 rounded flex justify-between border border-black" ]
                [ div [ tailwind "bg-white font-bold text-sm p-2 flex-grow border-r border-black" ] [ text (Diagnosis.toString diagnosis) ]
                , button [ onClick ClickedDeleteDiagnosis, tailwind "w-8 hover:bg-red-500 hover:text-white" ] [ text "🗑" ]
                ]


viewInvestigationOptions : CaseFinishData -> Html Msg
viewInvestigationOptions data =
    case data.filteredInvestigations of
        [] ->
            div [] []

        investigations ->
            section [ tailwind "absolute bg-white flex flex-col h-64 z-50 w-full shadow-lg overflow-auto border-l border-r border-b border-gray-300" ]
                (List.map viewOption investigations)


viewMedicationOptions : CaseFinishData -> Html Msg
viewMedicationOptions data =
    case data.filteredMedications of
        [] ->
            div [] []

        medications ->
            section [ tailwind "absolute bg-white flex flex-col h-64 z-50 w-full shadow-lg overflow-auto border-l border-r border-b border-gray-300" ]
                (List.map viewOption medications)


viewChosenInvestigation : Int -> Investigation -> Html Msg
viewChosenInvestigation index investigation =
    article [ tailwind "border border-black rounded font-bold mr-1 mb-1 flex" ]
        [ div [ tailwind "py-1 px-2 border-r border-black" ] [ text (Investigation.toString investigation) ]
        , button [ tailwind "px-1 hover:bg-red-500 hover:text-white", onClick (ClickedDeleteInvestigation index) ] [ text "🗑" ]
        ]


viewInvestigationSearch : Model -> CaseFinishData -> Html Msg
viewInvestigationSearch model data =
    section [ tailwind "w-full relative" ]
        [ input
            [ tailwind "text-sm p-2 shadow-inner w-full mt-2 border-b-2 border-gray-400 focus:border-olive-500 trans-all bg-gray-100 focus:bg-white"
            , placeholder "Search for investigations here."
            , onInput ChangedInvestigationSearch
            , value data.investigationSearch
            ]
            []
        , viewInvestigationOptions data
        , section [ tailwind "mt-4 flex flex-wrap text-sm border-t border-gray-300 pt-4" ]
            (Array.Extra.indexedMapToList viewChosenInvestigation data.chosenInvestigations)
        ]


viewChosenPrescription : Int -> Prescription -> Html Msg
viewChosenPrescription index prescription =
    article [ tailwind "border border-black rounded font-bold mr-1 mb-1 flex" ]
        [ div [ tailwind "px-2 w-11/12 py-1 border-r border-black flex" ]
            [ div [ tailwind "w-5/12" ] [ text (String.toUpper <| Medication.toString prescription.medication) ]
            , div [ tailwind "w-1/6 ml-2 text-right" ] [ text prescription.dosage ]
            , div [ tailwind "w-1/6 ml-2 text-right" ] [ text prescription.route ]
            , div [ tailwind "w-1/6 ml-2 text-right" ] [ text prescription.frequency ]
            ]
        , button [ tailwind "w-1/12  px-1 hover:bg-red-500 hover:text-white", onClick (ClickedDeletePrescription index) ] [ text "🗑" ]
        ]


viewPrescriptionAdder : Model -> CaseFinishData -> Html Msg
viewPrescriptionAdder model data =
    let
        addedSection =
            section [ tailwind "mt-4 flex flex-col text-sm border-t border-gray-300 pt-4 flex-grow overflow-auto" ]
                (Array.Extra.indexedMapToList viewChosenPrescription data.chosenPrescriptions)
    in
    case data.currentMedication of
        Nothing ->
            section [ tailwind "w-full relative mt-2 text-sm" ]
                [ input
                    [ tailwind "w-full shadow-inner border-b-2 border-gray-400 p-2 focus:border-olive-500 trans-all bg-gray-100 focus:bg-white"
                    , placeholder "Medication name"
                    , onInput ChangedMedicationSearch
                    , value data.medicationSearch
                    ]
                    []
                , viewMedicationOptions data
                , addedSection
                ]

        Just medication ->
            section [ tailwind "flex-grow flex flex-col" ]
                [ section [ tailwind "text-sm flex mt-2 relative w-full" ]
                    [ article [ tailwind "w-5/12 border border-black font-bold p-2 overflow-auto" ] [ text (String.toUpper (Medication.toString medication)) ]
                    , input
                        [ tailwind "w-1/6 shadow-inner border-b-2 border-gray-300 p-2 ml-2 bg-gray-100 focus:bg-white focus:border-olive-500 trans-all"
                        , placeholder "Dose"
                        , value data.prescriptionDose
                        , onInput ChangedDose
                        ]
                        []
                    , input
                        [ tailwind "w-1/6 shadow-inner border-b-2 border-gray-300 p-2 ml-2 bg-gray-100 focus:bg-white focus:border-olive-500 trans-all"
                        , placeholder "Route"
                        , value data.prescriptionRoute
                        , onInput ChangedRoute
                        ]
                        []
                    , input
                        [ tailwind "w-1/6 shadow-inner border-b-2 border-gray-300 p-2 ml-2 bg-gray-100 focus:bg-white focus:border-olive-500 trans-all"
                        , placeholder "Freq."
                        , value data.prescriptionFreq
                        , onInput ChangedFreq
                        ]
                        []
                    , button
                        [ onClick ClickedAddPrescription
                        , tailwind "w-1/12 border-2 border-olive-500 text-olive-500 flex justify-center items-center font-bold ml-2 hover:bg-olive-500 hover:text-white trans-all"
                        ]
                        [ text "+" ]
                    ]
                , addedSection
                ]


viewScreenCaseFinish : Model -> CaseFinishData -> Html Msg
viewScreenCaseFinish model data =
    let
        profileImg =
            model.flags.profiles
                |> Dict.get data.patient.details.id
                |> Maybe.withDefault ""

        bold string =
            span [ tailwind "font-bold" ] [ text string ]
    in
    section [ tailwind "flex bg-white w-screen h-screen" ]
        [ section [ tailwind "bg-white rounded-lg shadow w-1/3 p-8 pb-16 pt-4 h-full flex flex-col shadow-inner fade-in" ]
            [ section [ tailwind "flex p-8" ]
                [ img [ src profileImg, tailwind "hidden xl:block xl:w-32 xl:h-32 mr-2 xl:mr-4" ] []
                , section [ tailwind "flex-grow" ]
                    [ div [ tailwind "flex items-center " ]
                        [ h1 [ tailwind "mt-0 font-bold text-sm xl:text-xl mr-4" ] [ text (data.patient.details.firstName ++ " " ++ data.patient.details.lastName) ]
                        , h2 [ tailwind "mt-0 text-sm xl:text-xl" ] [ text (patientAgeGender data.patient.details) ]
                        ]
                    , p [ tailwind "text-gray-700 text-sm" ] [ text "Thanks for seeing the patient - please document your assessment on the right and specify a provisional primary diagnosis and any investigations & prescriptions you'd like to order." ]
                    ]
                ]
            , section [ tailwind "overflow-auto p-4 pt-2 text-xs shadow-inner rounded mt-4" ]
                [ section [ tailwind "text-xs flex-col-reverse flex pb-8" ]
                    (List.map viewConversationItem data.interaction.conversation)
                ]
            ]
        , section [ tailwind "w-2/3 h-full flex flex-col max-h-full fade-in text-sm" ]
            [ section [ tailwind "bg-white w-full p-12 pb-4 flex-grow mb-4 flex overflow-auto" ]
                [ section [ tailwind "w-1/2 flex flex-col mr-6" ]
                    [ section [ tailwind "mb-2 w-full" ]
                        [ text "Type your clinical note for "
                        , span [ tailwind "font-bold" ] [ text (String.join " " [ data.patient.details.firstName, data.patient.details.lastName ]) ]
                        , text " ("
                        , text (patientAgeGender data.patient.details)
                        , text ") below:"
                        ]
                    , textarea
                        [ tailwind "shadow-inner border-b-4 h-full p-4 focus:border-olive-500 leading-tight w-full overflow-auto font-mono trans-all bg-gray-100 focus:bg-white"
                        , value data.note
                        , style "resize" "none"
                        , placeholder "Type your clinical note for this encounter here."
                        , onInput ChangedNote
                        ]
                        []
                    ]
                , section [ tailwind "w-1/2 flex flex-col overflow-auto" ]
                    [ article [ tailwind "mb-4", style "height" "10%" ]
                        [ label [ tailwind "" ] [ text "Provisional ", bold "diagnosis", text ":" ]
                        , viewDiagnosisSearch model data
                        ]
                    , article [ tailwind "", style "height" "36%" ]
                        [ label [ tailwind "" ] [ bold "Pathology", text " and ", bold "radiology", text " requests:" ]
                        , viewInvestigationSearch model data
                        ]
                    , article [ tailwind "flex flex-col flex-grow" ]
                        [ label [ tailwind "" ] [ text "New ", bold "prescription", text " orders:" ]
                        , viewPrescriptionAdder model data
                        ]
                    ]
                ]
            , div [ tailwind "px-12 pb-16 w-full" ]
                [ button [ onClick ClickedFinishNote, tailwind "w-full p-2 text-lg bg-olive-500 font-bold text-white rounded hover:bg-olive-600 active:bg-olive-700 trans-all" ]
                    [ text "Finish Note" ]
                ]
            ]
        ]


viewRequestedInvestigation : Bool -> Set Int -> Set Int -> Investigation -> Html Msg
viewRequestedInvestigation isUser exemplar user item =
    let
        newClass =
            if isUser then
                if Set.member (Investigation.toInt item) exemplar then
                    ""

                else
                    "line-through text-red-400"

            else if Set.member (Investigation.toInt item) user then
                ""

            else
                "underline text-olive-600"
    in
    article
        [ class newClass ]
        [ text (Investigation.toString item) ]


viewRequestedPrescription : Bool -> Set Int -> Set Int -> Prescription -> Html Msg
viewRequestedPrescription isUser exemplar user item =
    let
        newClass =
            if isUser then
                if Set.member (Medication.toInt item.medication) exemplar then
                    ""

                else
                    "line-through text-red-400"

            else if Set.member (Medication.toInt item.medication) user then
                ""

            else
                "underline text-olive-600"
    in
    article
        [ class newClass ]
        [ text (Medication.toString item.medication)
        , text " "
        , text item.dosage
        , text " "
        , text item.route
        , text " "
        , text item.frequency
        ]


viewScreenCaseFeedback : Model -> CaseFeedbackData -> Html Msg
viewScreenCaseFeedback model data =
    let
        providedInvestigationIntSet =
            data.investigations |> List.map Investigation.toInt |> Set.fromList

        providedPrescriptionIntSet =
            data.prescriptions |> List.map (.medication >> Medication.toInt) |> Set.fromList

        ( userDiagnosisClass, exemplarDiagnosisClass ) =
            case data.diagnosis of
                Just diagnosis ->
                    if diagnosis == data.patient.exemplarDiagnosis then
                        ( "", "" )

                    else
                        ( "line-through text-red-400", "underline text-olive-600" )

                Nothing ->
                    ( "text-red-400", "underline-text-olive-600" )
    in
    section [ tailwind "overflow-x-hidden" ]
        [ section [ tailwind "h-screen w-full bg-white flex justify-center items-center fade-in" ]
            [ section [ tailwind "w-2/3 flex justify-center flex-col items-center", style "height" "75%" ]
                [ h1 [ tailwind "text-5xl font-bold" ] [ text "Thank you for helping ", text data.patient.details.firstName, text "." ]
                , section [ tailwind "bg-white w-2/3 overflow-auto border border-gray-300 rounded px-4 my-8", style "height" "70%" ]
                    [ markdown [ class "markdown" ] data.patient.commentary ]
                , button [ onClick ClickedGoHome, tailwind "w-2/3 shadow border-l-4 border-olive-500 hover:shadow-lg active:shadow-inner trans-all text-lg p-2 mb-4" ] [ text "Return Home" ]
                , h3 [ tailwind "text-sm text-gray-800" ] [ text "Or compare your answers with the exemplar below." ]
                ]
            ]
        , section [ tailwind "bg-white flex pb-16" ]
            [ section [ tailwind "w-1/2 p-16 border-r border-gray-300" ]
                [ h1 [ tailwind "font-bold" ] [ text "Your response:" ]
                , section [ tailwind "mb-6" ]
                    [ pre [ tailwind "font-sans leading-tight pre-wrap" ] [ text data.note ] ]
                , section [ tailwind "mb-6" ]
                    [ h1 [ tailwind "font-bold" ] [ text "Your provisional diagnosis:" ]
                    , div [ class userDiagnosisClass ]
                        [ text (data.diagnosis |> Maybe.map Diagnosis.toString |> Maybe.withDefault "No diagnosis provided.") ]
                    ]
                , section [ tailwind "mb-6" ]
                    [ h1 [ tailwind "font-bold" ] [ text "Your requested investigations:" ]
                    , section []
                        (List.map (viewRequestedInvestigation True data.exemplarInvestigationIntSet providedInvestigationIntSet) data.investigations)
                    ]
                , section [ tailwind "mb-6" ]
                    [ h1 [ tailwind "font-bold" ] [ text "Your prescription orders:" ]
                    , section []
                        (List.map (viewRequestedPrescription True data.exemplarPrescriptionIntSet providedPrescriptionIntSet) data.prescriptions)
                    ]
                ]
            , section [ tailwind "w-1/2 p-16" ]
                [ h1 [ tailwind "font-bold" ] [ text "Exemplar response:" ]
                , section [ tailwind "mb-6" ]
                    [ pre [ tailwind "font-sans leading-tight pre-wrap" ] [ text data.patient.exemplarNote ] ]
                , section [ tailwind "mb-6" ]
                    [ h1 [ tailwind "font-bold" ] [ text "Exemplar provisional diagnosis:" ]
                    , div [ class exemplarDiagnosisClass ] [ text (Diagnosis.toString data.patient.exemplarDiagnosis) ]
                    ]
                , section [ tailwind "mb-6" ]
                    [ h1 [ tailwind "font-bold" ] [ text "Exemplar requested investigations:" ]
                    , section []
                        (List.map (viewRequestedInvestigation False data.exemplarInvestigationIntSet providedInvestigationIntSet) data.patient.exemplarInvestigations)
                    ]
                , section [ tailwind "mb-6" ]
                    [ h1 [ tailwind "font-bold" ] [ text "Exemplar prescription orders:" ]
                    , section []
                        (List.map (viewRequestedPrescription False data.exemplarPrescriptionIntSet providedPrescriptionIntSet) data.patient.exemplarPrescriptions)
                    ]
                ]
            ]
        ]


view : Model -> Html Msg
view model =
    case model.screen of
        ScreenStart patients ->
            viewScreenStart model patients

        ScreenCaseStart data ->
            viewScreenCaseStart model data

        ScreenCaseInteract data ->
            viewScreenCaseInteract model data

        ScreenCaseFinish data ->
            viewScreenCaseFinish model data

        ScreenCaseFeedback data ->
            viewScreenCaseFeedback model data



-- SUBSCRIPTIONS --


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.screen of
        ScreenCaseInteract data ->
            if List.length data.responseQueue > 0 then
                Sub.batch
                    [ Time.every tickResponseFrequency TickResponse
                    , Time.every 1000 TickTimer
                    ]

            else
                Time.every 1000 TickTimer

        _ ->
            Sub.none



---- PROGRAM ----


main : Program Value Model Msg
main =
    Browser.element
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
