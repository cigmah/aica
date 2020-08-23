module Shared.Note exposing (..)

{-| Type representing a clinical note from encounters, like an admission or an op note
-}


type alias Note =
    { brief : String
    , full : String
    }


default : Note
default =
    { brief = ""
    , full = ""
    }
