module Prescription exposing (..)

import Medication exposing (Medication)


type alias Prescription =
    { medication : Medication
    , dosage : String
    , route : String
    , frequency : String
    }
