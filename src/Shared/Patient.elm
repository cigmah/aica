module Shared.Patient exposing (InProgress, Patient, defaultInProgress, urnGenerator)

{-| Type representing a full patient case.
-}

import Random exposing (Generator)
import Random.Char
import Random.String
import Shared.Diagnosis exposing (Diagnosis)
import Shared.Gender exposing (Gender(..))
import Shared.Investigation exposing (Investigation)
import Shared.Medication exposing (Medication)
import Shared.Note exposing (Note)
import Shared.Prescription exposing (Prescription)
import Shared.Result exposing (Result)


type alias InProgress =
    { firstName : String
    , lastName : String
    , dob : String
    , gender : Gender
    , urn : String
    , visitDateTime : String
    , stem : String
    , previousNotes : List Note
    , explanation : String
    , exampleNote : String
    , exampleDiagnosis : Maybe Diagnosis
    , examplePrescriptions : List Prescription
    , exampleResults : List Result
    }


urnGenerator : Generator String
urnGenerator =
    Random.String.string 10 (Random.Char.char 48 57)


defaultInProgress : InProgress
defaultInProgress =
    { firstName = ""
    , lastName = ""
    , dob = ""
    , gender = Unspecified
    , urn = "Generating..."
    , visitDateTime = "2020-03-02T09:30:00"
    , stem = ""
    , previousNotes = []
    , explanation = ""
    , exampleNote = ""
    , exampleDiagnosis = Nothing
    , examplePrescriptions = []
    , exampleResults = []
    }


type alias Patient =
    { id : String
    , firstName : String
    , lastName : String
    , dob : String
    , gender : Gender
    , urn : String
    , visitDateTime : String
    , stem : String
    , previousNotes : List Note
    , explanation : String
    , exampleNote : String
    , exampleDiagnosis : Diagnosis
    , examplePrescriptions : List Prescription
    , exampleResults : List Result
    }
