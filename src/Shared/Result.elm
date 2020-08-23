module Shared.Result exposing (Result, validate, withDefaults)

{-| Type representing an investigation result.
-}

import Shared.Investigation exposing (Investigation)
import Shared.Validating exposing (Validating(..))


type alias Result =
    { investigation : Investigation
    , result : String
    }


withDefaults : Investigation -> Result
withDefaults investigation =
    { investigation = investigation
    , result = ""
    }


validate : Result -> List Result -> Validating Result
validate result priors =
    let
        resultGreaterThan3 =
            (result.result |> String.trim |> String.length) > 3

        newInvestigation =
            not (List.member result.investigation (List.map .investigation priors))
    in
    if resultGreaterThan3 && newInvestigation then
        Valid result

    else
        Invalid [ "Result must be longer than 3 characters and must be for a new investigation." ]
