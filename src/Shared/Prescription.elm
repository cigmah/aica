module Shared.Prescription exposing (Prescription, withDefaults)

import Shared.Medication exposing (Medication)


{-| Type representing a proper prescription, including a medication, dosage, frequency and route.
-}
type alias Prescription =
    { medication : Medication
    , route : String
    , dose : String
    , frequency : String
    }


withDefaults : String -> String -> Prescription
withDefaults id name =
    { medication = { id = id, name = name }
    , route = ""
    , dose = ""
    , frequency = ""
    }
