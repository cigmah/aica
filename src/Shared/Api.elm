module Shared.Api exposing (RemoteData(..), decodeId, getDiagnoses, getInvestigations, getMedications, postDiagnosis, postInvestigation, postMedication)

import Config
import Http exposing (Error(..))
import Json.Decode as Decode exposing (Decoder, Value)
import Shared.Diagnosis as Diagnosis
import Shared.Investigation as Investigation
import Shared.Medication as Medication
import Url.Builder


type RemoteData a
    = NotAsked
    | Loading
    | Success a
    | Failure Error


{-| Convenience decoder for a single ID when adding new items to backend
-}
decodeId : Decoder String
decodeId =
    Decode.field "id" Decode.string


resultToRemoteData : Result Error a -> RemoteData a
resultToRemoteData result =
    case result of
        Ok a ->
            Success a

        Err e ->
            Failure e


makeUrl : List String -> String
makeUrl strings =
    Url.Builder.crossOrigin Config.backendUrl strings []


type Endpoint
    = Diagnoses
    | Investigations
    | Medications


endpointToUrl : Endpoint -> String
endpointToUrl endpoint =
    case endpoint of
        Diagnoses ->
            makeUrl [ "diagnoses.json" ]

        Investigations ->
            makeUrl [ "investigations.json" ]

        Medications ->
            makeUrl [ "medications.json" ]


getDiagnoses : (RemoteData Diagnosis.Index -> msg) -> Cmd msg
getDiagnoses msg =
    Http.get
        { url = endpointToUrl Diagnoses
        , expect = Http.expectJson (resultToRemoteData >> msg) Diagnosis.dictDecoder
        }


getInvestigations : (RemoteData Investigation.Index -> msg) -> Cmd msg
getInvestigations msg =
    Http.get
        { url = endpointToUrl Investigations
        , expect = Http.expectJson (resultToRemoteData >> msg) Investigation.dictDecoder
        }


getMedications : (RemoteData Medication.Index -> msg) -> Cmd msg
getMedications msg =
    Http.get
        { url = endpointToUrl Medications
        , expect = Http.expectJson (resultToRemoteData >> msg) Medication.dictDecoder
        }


postDiagnosis : Diagnosis.InProgress -> (RemoteData String -> msg) -> Cmd msg
postDiagnosis data callback =
    Http.post
        { url = endpointToUrl Diagnoses
        , body = Http.jsonBody (Diagnosis.encodeInProgress data)
        , expect = Http.expectJson (resultToRemoteData >> callback) decodeId
        }


postInvestigation : Investigation.InProgress -> (RemoteData String -> msg) -> Cmd msg
postInvestigation data callback =
    Http.post
        { url = endpointToUrl Investigations
        , body = Http.jsonBody (Investigation.encodeInProgress data)
        , expect = Http.expectJson (resultToRemoteData >> callback) decodeId
        }


postMedication : Medication.InProgress -> (RemoteData String -> msg) -> Cmd msg
postMedication data callback =
    Http.post
        { url = endpointToUrl Medications
        , body = Http.jsonBody (Medication.encodeInProgress data)
        , expect = Http.expectJson (resultToRemoteData >> callback) decodeId
        }
