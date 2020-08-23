module Shared.Medication exposing (InProgress, Index, Medication, defaultInProgress, dictDecoder, encodeInProgress, validate)

{-| Type representing a medication (name only), like perindopril or ventolin.
-}

import Dict exposing (Dict)
import Json.Decode as Decode exposing (Decoder, Value)
import Json.Encode as Encode
import Shared.Validating exposing (Validating(..))


type alias InProgress =
    { name : String }


defaultInProgress : InProgress
defaultInProgress =
    { name = "" }


encodeInProgress : InProgress -> Value
encodeInProgress data =
    Encode.object
        [ ( "name", Encode.string data.name ) ]


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


type alias Medication =
    { id : String
    , name : String
    }


type alias Index =
    Dict String Medication


dictDecoder : Decoder Index
dictDecoder =
    Decode.dict (Decode.field "name" Decode.string)
        |> Decode.map (Dict.map Medication)
