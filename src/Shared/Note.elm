module Shared.Note exposing (Note, default, validate)

{-| Type representing a clinical note from encounters, like an admission or an op note
-}

import Shared.Validating exposing (Validating(..))


type alias Note =
    { brief : String
    , full : String
    }


default : Note
default =
    { brief = ""
    , full = ""
    }


validate : Note -> Validating Note
validate note =
    let
        fullGreaterThan8 =
            (note.full |> String.trim |> String.length) > 8

        briefGreaterThan8 =
            (note.brief |> String.trim |> String.length) > 8
    in
    if fullGreaterThan8 && briefGreaterThan8 then
        Valid note

    else
        Invalid [ "Note must be longer than 8 characters." ]
