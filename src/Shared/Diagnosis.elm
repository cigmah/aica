module Shared.Diagnosis exposing (Diagnosis, InProgress, Index, defaultInProgress, dictDecoder, encodeInProgress)

{-| Type representing a medical diagnosis, like STEMI or asthma
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


type alias Diagnosis =
    { id : String
    , name : String
    }


type alias Index =
    Dict String Diagnosis


{-| Decoder for a dictionary of diagnoses, keyed by id.

Remote data will be in the form of this example:

    { "-MBwU_kDbVp_70jfwzmp":
        { "name": "Asthma" }
    , "-MBwUg_Y1lvCXrsqnsoC":
        { "name": "STEMI" }
    }

-}
dictDecoder : Decoder Index
dictDecoder =
    Decode.dict (Decode.field "name" Decode.string)
        |> Decode.map (Dict.map Diagnosis)
