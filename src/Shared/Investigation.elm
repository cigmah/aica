module Shared.Investigation exposing (InProgress, Index, Investigation, defaultInProgress, dictDecoder, encodeInProgress)

{-| Type representing an investigation, like a Chest X-Ray or FBE.
-}

import Dict exposing (Dict)
import Json.Decode as Decode exposing (Decoder, Value)
import Json.Encode as Encode
import Shared.Diagnosis exposing (defaultInProgress)


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
    , mode : Mode
    }


defaultInProgress : InProgress
defaultInProgress =
    { name = ""
    , mode = Pathology
    }


encodeInProgress : InProgress -> Value
encodeInProgress data =
    Encode.object
        [ ( "name", Encode.string data.name )
        , ( "mode", Encode.string (modeToString data.mode) )
        ]


type alias Investigation =
    { id : String
    , name : String
    , mode : Mode
    }


type alias Index =
    Dict String Investigation


dictDecoder : Decoder Index
dictDecoder =
    let
        tempInvestigation name mode =
            { name = name, mode = mode }

        tempDecoder =
            Decode.map2 tempInvestigation
                (Decode.field "name" Decode.string)
                (Decode.field "mode" modeDecoder)

        makeInvestigation id { name, mode } =
            { id = id, name = name, mode = mode }
    in
    Decode.dict tempDecoder
        |> Decode.map (Dict.map makeInvestigation)
