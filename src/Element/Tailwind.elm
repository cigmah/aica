module Element.Tailwind exposing (tailwind)

import Html exposing (..)
import Html.Attributes exposing (..)


tailwind : String -> Attribute msg
tailwind =
    class
