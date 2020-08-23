module Element.ButtonGhost exposing (Data, view)

import Element.Tailwind exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Data msg =
    { text : String
    , onClick : msg
    , type_ : String
    , disabled : Bool
    }


view : Data msg -> Html msg
view data =
    button
        [ type_ data.type_
        , onClick data.onClick
        , disabled data.disabled
        , tailwind "my-2 bg-white shadow hover:shadow-lg trans-all py-2 px-4 active:shadow-none"
        ]
        [ text data.text ]
