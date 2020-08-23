module Shared.Medication exposing (InProgress, Index, Medication, defaultInProgress, dictDecoder, encodeInProgress)

{-| Type representing a medication (name only), like perindopril or ventolin.
-}

import Dict exposing (Dict)
import Json.Decode as Decode exposing (Decoder, Value)
import Json.Encode as Encode


type alias InProgress =
    { name : String }


defaultInProgress : InProgress
defaultInProgress =
    { name = "" }


encodeInProgress : InProgress -> Value
encodeInProgress data =
    Encode.object
        [ ( "name", Encode.string data.name ) ]


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
