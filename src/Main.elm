module Main exposing (..)

{-| AICA: An Interactive Case Archive

Online medical cases with active interaction in the form of a (limited) chatbot.

-}

import Array exposing (Array)
import Array.Extra
import Browser
import Cases.Case as Case exposing (..)
import Cases.List
import Diagnosis exposing (..)
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
    , profiles : Array String
    }


decoderFlags : Decoder Flags
decoderFlags =
    Decode.map2 Flags
        (Decode.field "logo" Decode.string)
        (Decode.field "profiles" (Decode.array Decode.string))


defaultFlags =
    { logo = ""
    , profiles = Array.empty
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
    | ClickedPatient Int
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


findCase : Int -> Maybe Case
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
                    data
                        |> caseFeedbackDataInit
                        |> ScreenCaseFeedback
                        |> updateScreen model
                        |> withCmd Cmd.none

                _ ->
                    model |> withCmd Cmd.none



---- VIEW ----


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


viewBasicItem : Array String -> Case.Details -> Html Msg
viewBasicItem profiles patient =
    let
        profileImg =
            profiles
                |> Array.get patient.id
                |> Maybe.withDefault ""
    in
    article
        [ tailwind "m-4 group cursor-pointer shadow rounded-lg hover:bg-gray-200 h-48 w-48 relative trans-all overflow-hidden border-gray-300 border active:shadow-inner"
        , onClick (ClickedPatient patient.id)
        ]
        [ img [ src profileImg, tailwind "absolute" ] []
        , section [ tailwind "absolute bottom-0 p-2 bg-white group-hover:bg-black group-hover:text-white w-full trans-all rounded-b-lg" ]
            [ h1 [ tailwind "font-bold" ] [ text (patient.firstName ++ " " ++ patient.lastName) ]
            , div [ tailwind "flex between" ]
                [ h2 [ tailwind "mr-4" ] [ text (patientAgeGender patient) ]
                , h3 [] [ text patient.occupation ]
                ]
            ]
        ]


viewScreenStart : Model -> ScreenStartData -> Html Msg
viewScreenStart model patients =
    section [ tailwind "fade-in" ]
        [ section [ tailwind "lg:hidden h-screen w-full bg-green-500 p-4 flex flex-col items-center justify-center" ]
            [ img [ src model.flags.logo, tailwind "w-3/4 md:w-1/2 m-4" ] []
            , h1 [ tailwind "text-white text-lg font-bold text-center w-3/4 md:w-1/2" ]
                [ text "AICA is designed for desktop use. For your mobile revision needs, try our question bank, "
                , a [ href "https://aorta.cigmah.org", tailwind "underline" ] [ text "AORTA" ]
                , text "."
                ]
            ]
        , section [ tailwind "h-screen w-full bg-green-500 hidden lg:flex" ]
            [ section [ tailwind "w-1/3 p-8 flex flex-col items-center justify-center bg-green-500" ]
                [ img [ src model.flags.logo, tailwind "w-3/4 mb-8" ] []
                , section [ tailwind "w-3/4 mb-8" ]
                    [ h1 [ tailwind "text-5xl text-white font-bold mb-2" ] [ text "AICA" ]
                    , p [ tailwind "text-lg text-white" ]
                        [ span [ tailwind "font-bold" ] [ text "AICA" ]
                        , text " is "
                        , span [ tailwind "font-bold" ] [ text "An Interactive Case Archive" ]
                        , text ". Click on a patient on the right hand side to start an interactive case. You will learn about the patient by collecting information from a history and examination, then will assess and manage their presenting complaint."
                        ]
                    ]
                ]
            , section [ tailwind "w-2/3 p-8" ]
                [ section [ tailwind "bg-white h-full w-full overflow-auto shadow rounded" ]
                    [ div [ tailwind "p-4 flex flex-wrap" ]
                        (List.map (viewBasicItem model.flags.profiles) patients)
                    ]
                ]
            ]
        ]


viewScreenCaseStart : Model -> CaseStartData -> Html Msg
viewScreenCaseStart model data =
    let
        profileImg =
            model.flags.profiles
                |> Array.get data.patient.details.id
                |> Maybe.withDefault ""
    in
    section [ tailwind "flex p-12 bg-gray-200 w-screen h-screen" ]
        [ section [ tailwind "flex flex-col mr-12 w-1/3 items-center" ]
            [ div [ tailwind "bg-white w-full xl:w-3/4 rounded-b-none rounded shadow p-12" ] [ img [ tailwind "w-full", src profileImg ] [] ]
            , div [ tailwind "bg-white rounded rounded-t-none shadow text-xl w-full xl:w-3/4 p-4 mb-2" ]
                [ h1 [ tailwind "font-bold" ] [ text (data.patient.details.firstName ++ " " ++ data.patient.details.lastName) ]
                , div [ tailwind "flex between" ]
                    [ h2 [ tailwind "mr-4" ] [ text (patientAgeGender data.patient.details) ]
                    , h3 [] [ text data.patient.details.occupation ]
                    ]
                ]
            , button
                [ onClick ClickedGoHome
                , tailwind "w-full xl:w-3/4 cursor-pointer p-2 bg-white border-2 border-gray-500 rounded hover:bg-gray-300   trans-all mb-2 text-lg"
                ]
                [ text "Go Back" ]
            , button
                [ onClick (ClickedAssessPatient data.patient)
                , tailwind "w-full xl:w-3/4 cursor-pointer p-2 bg-blue-500 text-white hover:bg-blue-600 active:bg-blue-700 rounded trans-all text-lg"
                ]
                [ text "Assess Patient" ]
            ]
        , section [ tailwind "bg-white rounded-lg shadow w-2/3 p-8" ]
            [ Markdown.toHtml [ class "markdown" ] data.patient.stem ]
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
        [ tailwind "w-full flex pb-3"
        , classList
            [ ( "justify-start", isYou item.speaker )
            , ( "justify-end", isMe item.speaker )
            ]
        ]
        [ div
            [ tailwind "px-4 py-2"
            , classList
                [ ( "bg-gray-200 text-gray-700 rounded-r-lg rounded-tl-lg", isYou item.speaker )
                , ( "bg-blue-500 text-white rounded-l-lg rounded-tr-lg", isMe item.speaker )
                ]
            ]
            [ text item.value ]
        ]


viewScreenCaseInteract : Model -> CaseInteractData -> Html Msg
viewScreenCaseInteract model data =
    section [ tailwind "flex p-12 bg-gray-200 w-screen h-screen" ]
        [ section [ tailwind "flex flex-col mr-12 w-1/3 items-center" ]
            [ section [ tailwind "text-sm text-gray-600 mb-2 w-full" ]
                [ div [ tailwind "w-full" ]
                    [ viewTimer data ]
                ]
            , input
                [ type_ "text"
                , value data.currentSearch
                , onInput ChangedCurrentSearch
                , tailwind "w-full bg-white rounded shadow text-lg p-4 focus:border-blue-400 border-2 border-gray-700"
                ]
                []
            , section [ tailwind "mt-4 w-full overflow-auto mb-4 h-full" ] [ viewFilteredQuestions data ]
            , button
                [ onClick ClickedFinishInteraction
                , tailwind "bg-white border border-gray-300 p-2 w-full cursor-pointer hover:bg-blue-500 hover:text-white rounded"
                ]
                [ text "Finish Interaction" ]
            ]
        , section [ tailwind "bg-white rounded-lg shadow w-2/3 p-8 pt-4 flex flex-col" ]
            [ section [ tailwind "text-sm text-gray-500 w-full border-b border-gray-300 text-center bg-white h-12 flex justify-center items-center" ]
                [ text (isTypingText data) ]
            , section [ tailwind "flex flex-col-reverse overflow-hidden p-2" ]
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
            div [] [ text "There no questions matching what you've typed. Try typing something less specific, like 'when' or 'where', or a symptom like 'fever' or 'rash'!" ]

    else
        div []
            [ text "Type in at least 4 characters to search possible questions you can ask or examination findings you can check." ]


viewFilteredOption : Option.Data Question Msg -> Html Msg
viewFilteredOption data =
    button
        [ tailwind "mb-1 w-full text-left shadow p-3 bg-white hover:bg-blue-500 cursor-pointer hover:text-white focus:border-blue-400 border-2"
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
    button [ onClick option.onClick, tailwind "text-left p-1 hover:bg-blue-500 hover:text-white px-2 py-1 text-sm" ]
        [ text option.string ]


viewDiagnosisOptions : CaseFinishData -> Html Msg
viewDiagnosisOptions data =
    case data.filteredDiagnoses of
        [] ->
            div [] []

        diagnoses ->
            section [ tailwind "absolute bg-white flex flex-col h-64 z-50 w-full shadow-lg overflow-auto" ]
                (List.map viewOption diagnoses)


viewDiagnosisSearch : Model -> CaseFinishData -> Html Msg
viewDiagnosisSearch model data =
    case data.chosenDiagnosis of
        Nothing ->
            section [ tailwind "w-full relative" ]
                [ input
                    [ tailwind "text-sm py-1 px-2 shadow-inner w-full mt-2 border border-gray-300 focus:border-blue-400"
                    , placeholder "Search for a diagnosis here."
                    , onInput ChangedDiagnosisSearch
                    , value data.diagnosisSearch
                    ]
                    []
                , viewDiagnosisOptions data
                ]

        Just diagnosis ->
            article [ tailwind "w-full mt-2 rounded flex justify-between border border-black" ]
                [ div [ tailwind "bg-white font-bold text-sm py-1 px-2 flex-grow border-r border-black" ] [ text (Diagnosis.toString diagnosis) ]
                , button [ onClick ClickedDeleteDiagnosis, tailwind "w-8 hover:bg-red-500 hover:text-white" ] [ text "🗑" ]
                ]


viewInvestigationOptions : CaseFinishData -> Html Msg
viewInvestigationOptions data =
    case data.filteredInvestigations of
        [] ->
            div [] []

        investigations ->
            section [ tailwind "absolute bg-white flex flex-col h-64 z-50 w-full shadow-lg overflow-auto" ]
                (List.map viewOption investigations)


viewMedicationOptions : CaseFinishData -> Html Msg
viewMedicationOptions data =
    case data.filteredMedications of
        [] ->
            div [] []

        medications ->
            section [ tailwind "absolute bg-white flex flex-col h-64 z-50 w-full shadow-lg overflow-auto" ]
                (List.map viewOption medications)


viewChosenInvestigation : Int -> Investigation -> Html Msg
viewChosenInvestigation index investigation =
    article [ tailwind "border border-black rounded font-bold mr-1 mb-1 flex" ]
        [ div [ tailwind "px-2 py-1 border-r border-black" ] [ text (Investigation.toString investigation) ]
        , button [ tailwind "px-1 hover:bg-red-500 hover:text-white", onClick (ClickedDeleteInvestigation index) ] [ text "🗑" ]
        ]


viewInvestigationSearch : Model -> CaseFinishData -> Html Msg
viewInvestigationSearch model data =
    section [ tailwind "w-full relative" ]
        [ input
            [ tailwind "text-sm p-1 shadow-inner w-full mt-2 border border-gray-300 focus:border-blue-400"
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
                    [ tailwind "w-full shadow-inner border border-gray-300 p-1 focus:border-blue-400"
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
                    [ article [ tailwind "w-5/12 border border-black font-bold p-1 overflow-auto" ] [ text (String.toUpper (Medication.toString medication)) ]
                    , input
                        [ tailwind "w-1/6 shadow-inner border border-gray-300 p-1 ml-2"
                        , placeholder "Dose"
                        , value data.prescriptionDose
                        , onInput ChangedDose
                        ]
                        []
                    , input
                        [ tailwind "w-1/6 shadow-inner border border-gray-300 p-1 ml-2"
                        , placeholder "Route"
                        , value data.prescriptionRoute
                        , onInput ChangedRoute
                        ]
                        []
                    , input
                        [ tailwind "w-1/6 shadow-inner border border-gray-300 p-1 ml-2"
                        , placeholder "Freq."
                        , value data.prescriptionFreq
                        , onInput ChangedFreq
                        ]
                        []
                    , button
                        [ onClick ClickedAddPrescription
                        , tailwind "w-1/12 border-2 border-blue-500 text-blue-500 flex justify-center items-center font-bold ml-2 hover:bg-blue-500 hover:text-white"
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
                |> Array.get data.patient.details.id
                |> Maybe.withDefault ""

        bold string =
            span [ tailwind "font-bold" ] [ text string ]
    in
    section [ tailwind "flex p-12 bg-gray-200 w-screen h-screen" ]
        [ section [ tailwind "bg-white rounded-lg shadow w-1/3 p-8 pt-4 h-full flex flex-col" ]
            [ section [ tailwind "flex" ]
                [ img [ src profileImg, tailwind "w-48" ] []
                , section []
                    [ h1 [ tailwind "font-bold text-2xl" ] [ text (data.patient.details.firstName ++ " " ++ data.patient.details.lastName) ]
                    , h2 [ tailwind "mt-0" ] [ text (patientAgeGender data.patient.details) ]
                    ]
                ]
            , p [ tailwind "text-gray-700 text-sm my-2" ]
                [ text "Patient interaction transcript:" ]
            , section [ tailwind "overflow-auto p-4 text-xs border border-gray-300 rounded" ]
                [ section [ tailwind "text-xs flex-col-reverse flex" ]
                    (List.map viewConversationItem data.interaction.conversation)
                ]
            ]
        , section [ tailwind "ml-8 w-2/3 h-full flex flex-col max-h-full" ]
            [ section [ tailwind "bg-white shadow w-full p-4 flex-grow mb-4 flex overflow-auto" ]
                [ section [ tailwind "w-1/2 flex flex-col mr-6" ]
                    [ section [ tailwind "mb-2 w-full" ]
                        [ text "Type your clinical note for "
                        , span [ tailwind "font-bold" ] [ text (String.join " " [ data.patient.details.firstName, data.patient.details.lastName ]) ]
                        , text " ("
                        , text (patientAgeGender data.patient.details)
                        , text ") below:"
                        ]
                    , textarea
                        [ tailwind "shadow-inner border border-gray-300 h-full p-4 focus:border-blue-400 leading-tight w-full overflow-auto font-mono"
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
            , button [ onClick ClickedFinishNote, tailwind "w-full p-2 text-lg bg-blue-500 text-white rounded hover:bg-blue-600 active:bg-blue-700" ]
                [ text "Finish Note" ]
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

        _ ->
            div [] []



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
