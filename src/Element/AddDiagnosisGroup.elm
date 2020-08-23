module Element.AddDiagnosisGroup exposing (Data, view)

import Element.ButtonSubmit
import Element.Tailwind exposing (..)
import Element.TextInput
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Shared.Api exposing (..)
import Shared.Diagnosis as Diagnosis exposing (..)


type alias Data msg =
    { diagnosis : Diagnosis.InProgress
    , diagnoses : RemoteData Diagnosis.Index
    , remoteId : RemoteData String
    , onChangeName : String -> msg
    , onSubmit : msg
    }


view : Data msg -> Html msg
view data =
    Html.form
        [ tailwind "flex flex-col border-b border-gray-400 mb-8 pb-8"
        , onSubmit data.onSubmit
        ]
        [ label
            [ tailwind "text-grey-800" ]
            [ text "Add Diagnosis to Index" ]
        , Element.TextInput.view
            { label = "Name"
            , type_ = "text"
            , value = data.diagnosis.name
            , placeholder = "Enter a diagnosis name..."
            , onChange = data.onChangeName
            , disabled = isLoading data.remoteId
            }
        , Element.ButtonSubmit.view
            { text = "Add Diagnosis"
            , disabled = isLoading data.remoteId
            }
        , viewExtra data
        ]


viewExtra : Data msg -> Html msg
viewExtra data =
    case data.remoteId of
        Failure error ->
            div
                [ tailwind "text-red-500 text-center my-2 text-sm" ]
                [ text (errorToString error) ]

        Success id ->
            div
                [ tailwind "text-green-600 text-center my-2 text-sm" ]
                [ text ("Successfully added with ID: " ++ id) ]

        _ ->
            div [] []
