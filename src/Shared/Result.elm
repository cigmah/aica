module Shared.Result exposing (Result)

{-| Type representing an investigation result.
-}

import Shared.Investigation exposing (Investigation)


type alias Result =
    { investigation : Investigation
    , result : String
    }
