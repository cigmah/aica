module Element.MajorMinorColumn exposing (Data, view)

import Element.Tailwind exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Data msg =
    { major : List (Html msg)
    , minor : List (Html msg)
    }


view : Data msg -> Html msg
view data =
    article
        [ class "major-minor-column"
        , tailwind "w-full flex"
        ]
        [ section
            [ class "major-column"
            , tailwind "w-3/4 bg-white m-2 p-4 shadow rounded"
            ]
            data.major
        , section
            [ class "minor-column"
            , tailwind "w-1/4 bg-white m-2 p-4 shadow rounded"
            ]
            data.minor
        ]
