module Styles exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


build : List String -> Attribute msg
build strings =
    class (String.join " " strings)


tailwind : String -> Attribute msg
tailwind =
    class
