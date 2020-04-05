module Cases.Case exposing (..)

{-| Type definitions for interactive medical cases.
-}

import Array exposing (Array)
import Diagnosis exposing (Diagnosis)
import Investigations.Investigation as Investigation exposing (Investigation)
import Prescription exposing (Prescription)
import Questions.Question as Question exposing (Question)
import Set exposing (Set)
import Time exposing (Posix)


{-| Patient genders
-}
type Gender
    = Male
    | Female
    | Other String


type alias Details =
    { id : String
    , firstName : String
    , lastName : String
    , age : Int
    , gender : Gender
    , occupation : String
    , writer : String
    , illustrator : String
    }


type alias Case =
    { details : Details -- basic patient details
    , script :
        Int -- the question Id
        -> String -- the script is a (generated) function which converts a question into a string response
    , openingGreeting : String
    , stem : String
    , exemplarNote : String -- the exemplar clinical note for the case
    , exemplarDiagnosis : Diagnosis
    , exemplarInvestigations : List Investigation
    , exemplarPrescriptions : List Prescription
    , commentary : String
    }
