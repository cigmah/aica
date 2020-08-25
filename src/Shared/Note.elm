module Shared.Note exposing (Note, default, validate)

{-| Type representing a clinical note from encounters, like an admission or an op note
-}

import Shared.Validating exposing (Validating(..))


type alias Note =
    { brief : String
    , full : String
    , date : String
    }


default : Note
default =
    { brief = ""
    , full = ""
    , date = "2020-02-25"
    }


validate : Note -> Validating Note
validate note =
    let
        fullGreaterThan8 =
            (note.full |> String.trim |> String.length) > 3

        briefGreaterThan8 =
            (note.brief |> String.trim |> String.length) > 3

        dateExists =
            (note.brief |> String.trim |> String.length) > 0
    in
    if fullGreaterThan8 && briefGreaterThan8 && dateExists then
        Valid note

    else
        Invalid [ "Note must be longer than 8 characters." ]
