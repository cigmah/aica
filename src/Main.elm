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
import Interaction exposing (Interaction)
import Investigations.Investigation as Investigation exposing (Investigation)
import Json.Decode as Decode exposing (Decoder, Value)
import Json.Encode as Encode
import Medication exposing (Medication)
import Option
import Prescription exposing (Prescription)
import Questions.Question as Question exposing (Question)
import Styles exposing (..)



---- MODEL ----


type alias CaseStartData =
    { patient : Case }


caseStartDataInit : Case -> CaseStartData
caseStartDataInit patient =
    { patient = patient }


type alias CaseInteractData =
    { patient : Case
    , interaction : Interaction
    , currentSearch : String
    , filteredOptions : Array (Option.Data Question Msg)
    , currentSelected : Maybe (Option.Data Question Msg)
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
    div []
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
            , section [ tailwind "flex-grow p-8" ]
                [ section [ tailwind "bg-white h-full w-full overflow-auto shadow rounded" ]
                    [ div [ tailwind "p-4 flex flex-wrap" ]
                        (List.map (viewBasicItem model.flags.profiles) patients)
                    ]
                ]
            ]
        ]


viewScreenCaseStart : Model -> CaseStartData -> Html Msg
viewScreenCaseStart model data =
    div [] []


view : Model -> Html Msg
view model =
    case model.screen of
        ScreenStart patients ->
            viewScreenStart model patients

        _ ->
            div [] []



---- PROGRAM ----


main : Program Value Model Msg
main =
    Browser.element
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
