module Shared.Patient exposing (InProgress, Patient, defaultInProgress)

{-| Type representing a full patient case.
-}

import Shared.Diagnosis exposing (Diagnosis)
import Shared.Investigation exposing (Investigation)
import Shared.Medication exposing (Medication)
import Shared.Note exposing (Note)
import Shared.Prescription exposing (Prescription)
import Shared.Result exposing (Result)


type alias InProgress =
    { firstName : String
    , middleName : String
    , lastName : String
    , dob : String
    , visitDateTime : String
    , urn : String
    , stem : String
    , previousNotes : List Note
    , explanation : String
    , exampleNote : String
    , exampleDiagnosis : Maybe Diagnosis
    , examplePrescriptions : List Prescription
    , exampleResults : List Result
    }


defaultInProgress : InProgress
defaultInProgress =
    { firstName = ""
    , middleName = ""
    , lastName = ""
    , dob = ""
    , visitDateTime = ""
    , urn = ""
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
    , middleName : String
    , lastName : String
    , dob : String
    , visitDateTime : String
    , urn : String
    , stem : String
    , previousNotes : List Note
    , explanation : String
    , exampleNote : String
    , exampleDiagnosis : Diagnosis
    , examplePrescriptions : List Prescription
    , exampleResults : List Result
    }
