module Element.TextInput exposing (Data, view)

import Element.Tailwind exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Data msg =
    { label : String
    , type_ : String
    , value : String
    , placeholder : String
    , onChange : String -> msg
    , disabled : Bool
    }


view : Data msg -> Html msg
view data =
    article
        [ tailwind "flex flex-col w-full m-1" ]
        [ label
            [ tailwind "text-xs text-bold text-grey-600 mb-1"
            , for data.label
            ]
            [ text data.label ]
        , input
            [ type_ data.type_
            , id data.label
            , value data.value
            , placeholder data.placeholder
            , onInput data.onChange
            , disabled data.disabled
            , tailwind "bg-gray-200 shadow-inner p-1 hover:bg-white focus:bg-white trans-bg focus:border-blue-400 border-2"
            ]
            []
        ]
