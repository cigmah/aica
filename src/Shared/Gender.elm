module Shared.Gender exposing (..)

import String.Extra


type Gender
    = Male
    | Female
    | Unspecified


toString : Gender -> String
toString gender =
    case gender of
        Male ->
            "male"

        Female ->
            "female"

        Unspecified ->
            "unspecified"


toLetter : Gender -> String
toLetter gender =
    case gender of
        Male ->
            "M"

        Female ->
            "F"

        Unspecified ->
            "U"


fromString : String -> Maybe Gender
fromString string =
    case string of
        "male" ->
            Just Male

        "female" ->
            Just Female

        "unspecified" ->
            Just Unspecified

        _ ->
            Nothing


toOption : Gender -> { value : String, text : String }
toOption gender =
    { value = toString gender, text = toString gender |> String.Extra.toSentenceCase }


options : List { value : String, text : String }
options =
    List.map toOption [ Unspecified, Male, Female ]
