module Main exposing (..)

{-| AICA: An Interactive Case Archive

Online medical cases with active interaction in the form of a (limited) chatbot. 

-}

import Browser
import Array exposing (Array)
import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src)
import Cases.Case as Case exposing (Case)


---- MODEL ----

type alias CaseStartData = 
    { case : Case }

type alias CaseInteractData = 
    { case : Case 
    , interaction : Interaction }

type alias CaseFinishData = 
    { case : Case 
    , interaction : Interaction 
    , note : String
    , investigations : Array Investigation
    , prescription : Array Prescription }

type alias CaseFeedbackData = 
    { case : Case 
    , interaction : Interaction
    , note : String
    , investigations : Array Investigation 
    , prescription : Array Prescription }

type alias Screen = 
    | ScreenStart (List Case)
    | ScreenCaseStart CaseStartData
    | ScreenCaseInteract CaseInteractData
    | ScreenCaseFinish CaseFinishData
    | ScreenCaseFeedback CaseFeedbackData

type alias Model =
    {screen : Screen }


init : ( Model, Cmd Msg )
init =
    ( ScreenStart [], Cmd.none )



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
