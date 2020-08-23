module Element.AddInvestigationGroup exposing (Data, view)

import Element.ButtonSubmit
import Element.SelectSimple
import Element.Tailwind exposing (..)
import Element.TextInput
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Shared.Api exposing (..)
import Shared.Investigation as Investigation exposing (..)


type alias Data msg =
    { investigation : Investigation.InProgress
    , investigations : RemoteData Investigation.Index
    , remoteId : RemoteData String
    , onChangeName : String -> msg
    , onChangeBrief : String -> msg
    , onChangeMode : String -> msg
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
            [ text "Add Investigation to Index" ]
        , Element.TextInput.view
            { label = "Full Name"
            , type_ = "text"
            , value = data.investigation.name
            , placeholder = "Enter a full investigation name e.g. Chest X-ray"
            , onChange = data.onChangeName
            , disabled = isLoading data.remoteId
            }
        , Element.TextInput.view
            { label = "Brief Name"
            , type_ = "text"
            , value = data.investigation.brief
            , placeholder = "Enter a brief name e.g. CXR..."
            , onChange = data.onChangeBrief
            , disabled = isLoading data.remoteId
            }
        , Element.SelectSimple.view
            { label = "Investigation Type"
            , value = data.investigation.mode |> Investigation.modeToString
            , options = Investigation.modeOptions
            , onInput = data.onChangeMode
            }
        , Element.ButtonSubmit.view
            { text = "Add Investigation"
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
