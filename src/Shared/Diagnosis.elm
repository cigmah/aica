module Shared.Diagnosis exposing (Diagnosis, InProgress, Index, defaultInProgress, dictDecoder, encodeInProgress, fromInProgress, validate)

{-| Type representing a medical diagnosis, like STEMI or asthma
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
        [ ( "name", Encode.string data.name ) ]


type alias Diagnosis =
    { id : String
    , name : String
    }


fromInProgress : String -> InProgress -> Diagnosis
fromInProgress id { name } =
    { id = id, name = name }


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
