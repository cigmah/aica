module Shared.Investigation exposing (InProgress, Index, Investigation, Mode(..), defaultInProgress, dictDecoder, encodeInProgress, fromInProgress, modeOptions, modeToString, stringToMode, validate)

{-| Type representing an investigation, like a Chest X-Ray or FBE.
-}

import Dict exposing (Dict)
import Json.Decode as Decode exposing (Decoder, Value)
import Json.Encode as Encode
import Shared.Diagnosis exposing (defaultInProgress)
import Shared.Validating exposing (Validating(..))
import String.Extra


type Mode
    = Radiology
    | Pathology


stringToMode : String -> Maybe Mode
stringToMode string =
    case string of
        "radiology" ->
            Just Radiology

        "pathology" ->
            Just Pathology

        _ ->
            Nothing


modeToString : Mode -> String
modeToString mode =
    case mode of
        Radiology ->
            "radiology"

        Pathology ->
            "pathology"


modeToOption : Mode -> { value : String, text : String }
modeToOption mode =
    { value = modeToString mode
    , text = modeToString mode |> String.Extra.toSentenceCase
    }


modeOptions : List { value : String, text : String }
modeOptions =
    List.map modeToOption
        [ Pathology, Radiology ]


modeDecoder : Decoder Mode
modeDecoder =
    Decode.string
        |> Decode.map stringToMode
        |> Decode.andThen
            (\maybeMode ->
                case maybeMode of
                    Just mode ->
                        Decode.succeed mode

                    Nothing ->
                        Decode.fail "Invalid investigation mode."
            )


{-| An investigation in-progress without an established backend ID
-}
type alias InProgress =
    { name : String
    , brief : String
    , mode : Mode
    }


defaultInProgress : InProgress
defaultInProgress =
    { name = ""
    , brief = ""
    , mode = Pathology
    }


validate : InProgress -> Validating InProgress
validate data =
    let
        nameLongerThan2 =
            (data.name |> String.trim |> String.length) > 2
    in
    if nameLongerThan2 then
        Valid data

    else
        Invalid [ "Name must be at least 3 characters." ]


encodeInProgress : InProgress -> Value
encodeInProgress data =
    Encode.object
        [ ( "name", Encode.string data.name )
        , ( "brief", Encode.string data.brief )
        , ( "mode", Encode.string (modeToString data.mode) )
        ]


type alias Investigation =
    { id : String
    , name : String
    , brief : String
    , mode : Mode
    }


type alias Index =
    Dict String Investigation


fromInProgress : String -> InProgress -> Investigation
fromInProgress id { name, brief, mode } =
    { id = id, name = name, brief = brief, mode = mode }


dictDecoder : Decoder Index
dictDecoder =
    let
        tempDecoder =
            Decode.map3 InProgress
                (Decode.field "name" Decode.string)
                (Decode.field "brief" Decode.string)
                (Decode.field "mode" modeDecoder)
    in
    Decode.dict tempDecoder
        |> Decode.map (Dict.map fromInProgress)
