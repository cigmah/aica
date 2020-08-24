module Element.TextArea exposing (Data, view)

import Element.Tailwind exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Data msg =
    { label : String
    , value : String
    , rows : Int
    , onInput : String -> msg
    , disabled : Bool
    , placeholder : String
    }


view : Data msg -> Html msg
view data =
    article
        [ tailwind "flex flex-col w-full m-1" ]
        [ label
            [ for data.label
            , tailwind "text-xs text-bold text-grey-600 mb-1"
            ]
            [ text data.label ]
        , textarea
            [ id data.label
            , name data.label
            , rows data.rows
            , value data.value
            , onInput data.onInput
            , disabled data.disabled
            , placeholder data.placeholder
            , tailwind "bg-gray-200 shadow-inner p-1 hover:bg-white focus:bg-white trans-bg focus:border-blue-400 border-2"
            ]
            []
        ]
