module Element.ButtonSubmit exposing (Data, view)

import Element.Tailwind exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Data =
    { text : String
    , disabled : Bool
    }


view : Data -> Html msg
view data =
    button
        [ type_ "submit"
        , disabled data.disabled
        , tailwind "my-2 bg-white border-l-8 border-blue-500 shadow hover:shadow-lg trans-all py-2 px-4 active:shadow-none"
        ]
        [ text data.text ]
