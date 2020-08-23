module Element.SelectSimple exposing (Data, view)

import Element.Tailwind exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias OptionData =
    { value : String
    , text : String
    }


type alias Data msg =
    { label : String
    , value : String
    , options : List OptionData
    , onInput : String -> msg
    }


viewOption : OptionData -> Html msg
viewOption data =
    option
        [ value data.value ]
        [ text data.text ]


view : Data msg -> Html msg
view data =
    article
        [ tailwind "flex flex-col m-1 w-full" ]
        [ label
            [ for data.label
            , tailwind "text-xs text-bold text-grey-600 mb-1"
            ]
            [ text data.label ]
        , select
            [ name data.label
            , value data.value
            , id data.label
            , tailwind "bg-gray-200 shadow-inner p-1 hover:bg-white focus:bg-white trans-bg focus:border-blue-400 border-2"
            , onInput data.onInput
            ]
            (List.map viewOption data.options)
        ]
