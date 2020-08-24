module Element.EditStemWithPreview exposing (Data, view)

import Element.Tailwind exposing (..)
import Element.TextArea
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Shared.Markdown as Markdown
import Shared.Patient as Patient exposing (..)


type alias Data msg =
    { patient : Patient.InProgress
    , onChangeStem : String -> msg
    }


view : Data msg -> Html msg
view data =
    section
        [ tailwind "flex" ]
        [ Element.TextArea.view
            { label = "Scenario Stem"
            , value = data.patient.stem
            , rows = 10
            , onInput = data.onChangeStem
            , disabled = False
            , placeholder = "Write the scenario stem. You can use Markdown to format the your text."
            }
        , article
            [ tailwind "w-full flex flex-col m-1"
            ]
            [ label
                [ tailwind "text-xs text-bold text-grey-600 mb-1" ]
                [ text "Scenario Stem Markdown Preview" ]
            , section
                [ tailwind "border p-4 flex-grow" ]
                [ Markdown.toHtml data.patient.stem ]
            ]
        ]
