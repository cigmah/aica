module Main exposing (..)

{-| AICA: An Interactive Case Archive

Online medical cases with active interaction in the form of a (limited) chatbot.

-}

import Array exposing (Array)
import Browser
import Cases.Case as Case exposing (Case)
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)
import Interaction exposing (Interaction)
import Investigations.Investigation as Investigation exposing (Investigation)
import Medication exposing (Medication)
import Option
import Prescription exposing (Prescription)
import Questions.Question as Question exposing (Question)



---- MODEL ----


type alias CaseStartData =
    { patient : Case }


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


type Screen
    = ScreenStart (List Case)
    | ScreenCaseStart CaseStartData
    | ScreenCaseInteract CaseInteractData
    | ScreenCaseFinish CaseFinishData
    | ScreenCaseFeedback CaseFeedbackData


type alias Model =
    { screen : Screen }


init : ( Model, Cmd Msg )
init =
    ( { screen = ScreenStart [] }, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working!" ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
