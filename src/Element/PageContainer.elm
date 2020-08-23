module Element.PageContainer exposing (Data, view)

import Element.Tailwind exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Data msg =
    { body : List (Html msg) }


view : Data msg -> Html msg
view data =
    main_
        [ class "page-container"
        , id "page-container"
        , tailwind "w-full bg-gray-100 min-h-screen p-8"
        ]
        data.body
