module Main exposing (..)

{-| AICA: An Interactive Case Archive

Online medical cases with active interaction in the form of a (limited) chatbot.

-}

import Array exposing (Array)
import Browser
import Cases.Case as Case exposing (..)
import Cases.List
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
    , filteredOptions : Array (Option.Data Question Msg)
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
    , filteredOptions = Array.empty
    , currentSelected = Nothing
    }


type PrescriptionModal
    = PrescriptionModalHidden
    | PrescriptionModalVisible Prescription


type alias CaseFinishData =
    { patient : Case
    , interaction : Interaction
    , note : String
    , investigationSearch : String
    , filteredInvestigations : Array (Option.Data Investigation Msg)
    , chosenInvestigations : Array Investigation
    , medicationSearch : String
    , filteredMedications : Array (Option.Data Medication Msg)
    , prescriptionModal : PrescriptionModal
    , chosenPrescriptions : Array Prescription
    }


caseFinishDataInit : CaseInteractData -> CaseFinishData
caseFinishDataInit data =
    { patient = data.patient
    , interaction = data.interaction
    , note = ""
    , investigationSearch = ""
    , filteredInvestigations = Array.empty
    , chosenInvestigations = Array.empty
    , medicationSearch = ""
    , filteredMedications = Array.empty
    , prescriptionModal = PrescriptionModalHidden
    , chosenPrescriptions = Array.empty
    }


type alias CaseFeedbackData =
    { patient : Case
    , interaction : Interaction
    , note : String
    , investigations : Array Investigation
    , prescription : Array Prescription
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


processSearch : String -> CaseInteractData -> Screen
processSearch filter data =
    if String.length filter >= minTypeLength then
        let
            filteredOptions =
                Question.optionList ClickedQuestion
                    |> Array.filter (validQuestion filter)
        in
        { data | currentSearch = filter, filteredOptions = filteredOptions }
            |> ScreenCaseInteract

    else
        { data | currentSearch = filter, filteredOptions = Array.empty }
            |> ScreenCaseInteract


{-| Minimium number of characters to type before filtering questions.
-}
minTypeLength =
    3


updateResponseQueue : CaseInteractData -> Response -> CaseInteractData
updateResponseQueue ({ responseQueue } as data) response =
    { data | responseQueue = response :: responseQueue }


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
                            { data | interaction = Interaction.addQuestionToInteraction data.interaction string }
                    in
                    data.patient.script questionId
                        |> Interaction.createQueueItem string
                        |> updateResponseQueue newData
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
                , ( "bg-blue-600 text-white rounded-l-lg rounded-tr-lg", isMe item.speaker )
                ]
            ]
            [ text item.value ]
        ]


viewScreenCaseInteract : Model -> CaseInteractData -> Html Msg
viewScreenCaseInteract model data =
    section [ tailwind "flex p-12 bg-gray-200 w-screen h-screen" ]
        [ section [ tailwind "flex flex-col mr-12 w-1/3 items-center" ]
            [ input
                [ type_ "text"
                , value data.currentSearch
                , onInput ChangedCurrentSearch
                , tailwind "w-full bg-white rounded shadow text-lg p-4 focus:border-blue-400 border-2 border-gray-700"
                ]
                []
            , section [ tailwind "mt-4 w-full overflow-auto mb-4 h-full pr-4" ] [ viewFilteredQuestions data ]
            ]
        , section [ tailwind "bg-white rounded-lg shadow w-2/3 p-8 pt-4 flex flex-col" ]
            [ section [ tailwind "text-sm text-gray-500 w-full border-b border-gray-300 text-center bg-white h-12 pb-2" ]
                [ text (isTypingText data) ]
            , section [ tailwind "flex flex-col-reverse overflow-hidden p-2" ]
                (List.map viewConversationItem data.interaction.conversation)
            ]
        ]


viewFilteredQuestions : CaseInteractData -> Html Msg
viewFilteredQuestions data =
    if String.length data.currentSearch >= minTypeLength then
        if Array.length data.filteredOptions > 0 then
            div []
                (Array.toList (Array.map viewFilteredOption data.filteredOptions))

        else
            div [] [ text "There no questions matching what you've typed. Try typing something less specific, like 'when' or 'where', or a symptom like 'fever' or 'rash'!" ]

    else
        div []
            [ text "Type in at least 4 characters to filter the questions and examination findings you can ask this patient." ]


viewFilteredOption : Option.Data Question Msg -> Html Msg
viewFilteredOption data =
    article
        [ tailwind "mb-2 shadow p-3 bg-white hover:bg-blue-500 cursor-pointer hover:text-white"
        , onClick data.onClick
        ]
        [ text data.string ]


view : Model -> Html Msg
view model =
    case model.screen of
        ScreenStart patients ->
            viewScreenStart model patients

        ScreenCaseStart data ->
            viewScreenCaseStart model data

        ScreenCaseInteract data ->
            viewScreenCaseInteract model data

        _ ->
            div [] []


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
