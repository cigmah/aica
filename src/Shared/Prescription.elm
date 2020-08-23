module Shared.Prescription exposing (Prescription, validate, withDefaults)

import Shared.Medication exposing (Medication)
import Shared.Validating exposing (Validating(..))


{-| Type representing a proper prescription, including a medication, dosage, frequency and route.
-}
type alias Prescription =
    { medication : Medication
    , route : String
    , dose : String
    , frequency : String
    }


withDefaults : Medication -> Prescription
withDefaults medication =
    { medication = medication
    , route = ""
    , dose = ""
    , frequency = ""
    }


validate : Prescription -> List Prescription -> Validating Prescription
validate prescription priors =
    let
        allFields =
            String.length prescription.route >= 1 && String.length prescription.dose >= 1 && String.length prescription.frequency >= 1
    in
    if allFields then
        Valid prescription

    else
        Invalid [ "All prescription fields must be at least one character." ]
