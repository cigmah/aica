module Element.EditPatientBasicGroup exposing (Data, view)

import Element.SelectSimple
import Element.Tailwind exposing (..)
import Element.TextInput
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Shared.Gender as Gender
import Shared.Patient as Patient exposing (..)


type alias Data msg =
    { patient : Patient.InProgress
    , onChangeFirstName : String -> msg
    , onChangeLastName : String -> msg
    , onChangeDob : String -> msg
    , onChangeGender : String -> msg
    , onChangeUrn : String -> msg
    , onChangeVisitDateTime : String -> msg
    }


view : Data msg -> Html msg
view data =
    article
        []
        [ section
            [ tailwind "flex w-full" ]
            [ Element.TextInput.view
                { label = "First Name"
                , type_ = "text"
                , value = data.patient.firstName
                , placeholder = "Patient's first name..."
                , onChange = data.onChangeFirstName
                , disabled = False
                }
            , Element.TextInput.view
                { label = "Last Name"
                , type_ = "text"
                , value = data.patient.lastName
                , placeholder = "Patient's last name..."
                , onChange = data.onChangeLastName
                , disabled = False
                }
            ]
        , section
            [ tailwind "flex w-full" ]
            [ Element.TextInput.view
                { label = "Date of Birth"
                , type_ = "date"
                , value = data.patient.dob
                , placeholder = ""
                , onChange = data.onChangeDob
                , disabled = False
                }
            , Element.SelectSimple.view
                { label = "Gender"
                , value = data.patient.gender |> Gender.toString
                , options = Gender.options
                , onInput = data.onChangeGender
                }
            ]
        , section
            [ tailwind "flex w-full" ]
            [ Element.TextInput.view
                { label = "Visit Datetime"
                , type_ = "datetime-local"
                , value = data.patient.visitDateTime
                , placeholder = "Date and time of this patient's healthcare visit..."
                , onChange = data.onChangeVisitDateTime
                , disabled = False
                }
            , Element.TextInput.view
                { label = "URN"
                , type_ = "text"
                , value = data.patient.urn
                , placeholder = "Patient's URN..."
                , onChange = data.onChangeUrn
                , disabled = True
                }
            ]
        ]
