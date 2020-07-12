module Main exposing (..)

import Browser
import Dict exposing (Dict)
import Html exposing (Html, button, div, input, option, select, span, text)
import Html.Attributes exposing (disabled, placeholder, selected, type_, value)
import Html.Events exposing (onClick, onInput)
import Http
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)
import List exposing (append)
import String exposing (String)



-- APIS


getAll : () -> Cmd Msg
getAll () =
    Cmd.batch [ getDiagnoses (), getMedications () ]


getDiagnoses : () -> Cmd Msg
getDiagnoses () =
    Http.get
        { url = "https://aica-cigmah.firebaseio.com/diagnoses.json"
        , expect = Http.expectJson GotDiagnoses diagnosesDecoder
        }


getMedications : () -> Cmd Msg
getMedications () =
    Http.get
        { url = "https://aica-cigmah.firebaseio.com/medications.json"
        , expect = Http.expectJson GotMedications medicationsDecoder
        }



-- APIS
-- Decoders/


diagnosesDecoder : Decoder (Dict String String)
diagnosesDecoder =
    Decode.keyValuePairs (Decode.field "diagnosis" Decode.string)
        |> Decode.map Dict.fromList


medicationsDecoder : Decoder (Dict String String)
medicationsDecoder =
    Decode.keyValuePairs (Decode.field "medication" Decode.string)
        |> Decode.map Dict.fromList


idDecoder : Decoder String
idDecoder =
    Decode.field "name" Decode.string



-- Decoders
-- Encoders


diagnosisEncoder : String -> Value
diagnosisEncoder diagnosis =
    Encode.object
        [ ( "diagnosis", Encode.string diagnosis ) ]



-- Endoders
-- Custom Definitions


type RemoteData a
    = NotAsked
    | Loading
    | Success a
    | Failure Http.Error


type alias Patient =
    { firstName : String
    , middleName : String
    , lastName : String
    , dob : String
    , visitDateTime : String
    , urn : String
    , stem : String
    , explanation : String
    , exampleNote : String
    , diagnosisId : Maybe String
    , exampleMedications : List PatientMedication
    }


defaultPatient : Patient
defaultPatient =
    { firstName = ""
    , middleName = ""
    , lastName = ""
    , dob = ""
    , visitDateTime = ""
    , urn = ""
    , stem = ""
    , explanation = ""
    , exampleNote = ""
    , diagnosisId = Nothing
    , exampleMedications = []
    }


type alias PatientMedication =
    { medicationId : String
    , medicationName : String
    , dose : String
    , route : String
    , frequency : String
    }


type alias Model =
    { diagnosis : String
    , id : String
    , patient : Patient
    , diagnoses : RemoteData (Dict String String)
    , medications : RemoteData (Dict String String)
    , newPatientMedication : Maybe PatientMedication
    }


init : ( Model, Cmd Msg )
init =
    ( { diagnosis = ""
      , id = "Not submitted"
      , patient = defaultPatient
      , diagnoses = Loading
      , medications = Loading
      , newPatientMedication = Nothing
      }
    , getAll ()
    )



-- Messages


type Msg
    = ChangedDiagnosis String
    | ChangedPatient PatientField
    | SubmittedDiagnosis
    | GotDiagnosisId (Result Http.Error String)
    | GotDiagnoses (Result Http.Error (Dict String String))
    | GotMedications (Result Http.Error (Dict String String))
    | ChangedNewPatientMedication PatientMedicationField


type PatientField
    = FirstName String
    | MiddleName String
    | LastName String
    | Dob String
    | VisitDateTime String
    | Urn String
    | Stem String
    | Explanation String
    | ExampleNote String
    | DiagnosisId String
    | AddMedication PatientMedication


type PatientMedicationField
    = MedicationIdentity String String
    | Dose String
    | Route String
    | Frequency String



-- Messages


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ patient, newPatientMedication } as model) =
    case msg of
        ChangedDiagnosis diagnosis ->
            ( { model | diagnosis = diagnosis }, Cmd.none )

        ChangedPatient patientField ->
            case patientField of
                FirstName firstName ->
                    ( { model | patient = { patient | firstName = firstName } }
                    , Cmd.none
                    )

                MiddleName middleName ->
                    ( { model
                        | patient =
                            { patient | middleName = middleName }
                      }
                    , Cmd.none
                    )

                LastName lastName ->
                    ( { model | patient = { patient | lastName = lastName } }
                    , Cmd.none
                    )

                Dob dob ->
                    ( { model | patient = { patient | dob = dob } }, Cmd.none )

                VisitDateTime visitDateTime ->
                    ( { model
                        | patient = { patient | visitDateTime = visitDateTime }
                      }
                    , Cmd.none
                    )

                Urn urn ->
                    ( { model | patient = { patient | urn = urn } }, Cmd.none )

                Stem stem ->
                    ( { model | patient = { patient | stem = stem } }
                    , Cmd.none
                    )

                Explanation explanation ->
                    ( { model
                        | patient =
                            { patient | explanation = explanation }
                      }
                    , Cmd.none
                    )

                ExampleNote exampleNote ->
                    ( { model
                        | patient =
                            { patient | exampleNote = exampleNote }
                      }
                    , Cmd.none
                    )

                DiagnosisId diagnosisId ->
                    ( { model
                        | patient =
                            { patient | diagnosisId = Just diagnosisId }
                      }
                    , Cmd.none
                    )

                AddMedication patientMedication ->
                    ( { model
                        | patient =
                            { patient
                                | exampleMedications =
                                    append patient.exampleMedications
                                        [ patientMedication ]
                            }
                        , newPatientMedication = Nothing
                      }
                    , Cmd.none
                    )

        SubmittedDiagnosis ->
            ( model
            , Http.post
                { url = "https://aica-cigmah.firebaseio.com/diagnoses.json"
                , body = Http.jsonBody (diagnosisEncoder model.diagnosis)
                , expect = Http.expectJson GotDiagnosisId idDecoder
                }
            )

        GotDiagnosisId result ->
            case result of
                Ok id ->
                    ( { model | id = id }, Cmd.none )

                Err _ ->
                    ( { model | id = "Submit failed, please try again" }
                    , Cmd.none
                    )

        GotDiagnoses result ->
            case result of
                Ok diagnoses ->
                    ( { model | diagnoses = Success diagnoses }, Cmd.none )

                Err e ->
                    ( { model | diagnoses = Failure e }, Cmd.none )

        GotMedications result ->
            case result of
                Ok medications ->
                    ( { model | medications = Success medications }, Cmd.none )

                Err e ->
                    ( { model | medications = Failure e }, Cmd.none )

        ChangedNewPatientMedication patientMedicationField ->
            case newPatientMedication of
                Nothing ->
                    case patientMedicationField of
                        MedicationIdentity medicationId medicationName ->
                            ( { model
                                | newPatientMedication =
                                    Just
                                        { medicationId = medicationId
                                        , medicationName = medicationName
                                        , dose = ""
                                        , route = ""
                                        , frequency = ""
                                        }
                              }
                            , Cmd.none
                            )

                        _ ->
                            ( model, Cmd.none )

                Just patientMedication ->
                    case patientMedicationField of
                        MedicationIdentity medicationId medicationName ->
                            ( { model
                                | newPatientMedication =
                                    Just
                                        { patientMedication
                                            | medicationId = medicationId
                                            , medicationName = medicationName
                                        }
                              }
                            , Cmd.none
                            )

                        Dose dose ->
                            ( { model
                                | newPatientMedication =
                                    Just { patientMedication | dose = dose }
                              }
                            , Cmd.none
                            )

                        Route route ->
                            ( { model
                                | newPatientMedication =
                                    Just { patientMedication | route = route }
                              }
                            , Cmd.none
                            )

                        Frequency frequency ->
                            ( { model
                                | newPatientMedication =
                                    Just
                                        { patientMedication
                                            | frequency = frequency
                                        }
                              }
                            , Cmd.none
                            )


view : Model -> Html Msg
view model =
    div []
        [ viewInput "text"
            "Diagnosis Description"
            model.diagnosis
            ChangedDiagnosis
        , button [ onClick SubmittedDiagnosis ] [ text "Submit" ]
        , div [] [ text model.id ]
        , div []
            [ text "Patient Information"
            , div [] []
            , input
                [ type_ "text"
                , placeholder "First name"
                , value model.patient.firstName
                , onInput (ChangedPatient << FirstName)
                ]
                []
            , input
                [ type_ "text"
                , placeholder "Middle name"
                , value model.patient.middleName
                , onInput (ChangedPatient << MiddleName)
                ]
                []
            , input
                [ type_ "text"
                , placeholder "Last name"
                , value model.patient.lastName
                , onInput (ChangedPatient << LastName)
                ]
                []
            , input
                [ type_ "date"
                , placeholder "Date of birth"
                , value model.patient.dob
                , onInput (ChangedPatient << Dob)
                ]
                []
            , input
                [ type_ "datetime-local"
                , placeholder "Visit datetime"
                , value model.patient.visitDateTime
                , onInput (ChangedPatient << VisitDateTime)
                ]
                []
            , input
                [ type_ "text"
                , placeholder "URN"
                , value model.patient.urn
                , onInput (ChangedPatient << Urn)
                ]
                []
            , input
                [ type_ "text"
                , placeholder "Stem"
                , value model.patient.stem
                , onInput (ChangedPatient << Stem)
                ]
                []
            , input
                [ type_ "text"
                , placeholder "Explanation"
                , value model.patient.explanation
                , onInput (ChangedPatient << Explanation)
                ]
                []
            , input
                [ type_ "text"
                , placeholder "Example note"
                , value model.patient.exampleNote
                , onInput (ChangedPatient << ExampleNote)
                ]
                []
            ]
        , div []
            [ text "Diagnosis"
            , div [] []
            , diagnosisSelectInput model.diagnoses
                model.patient.diagnosisId
                (ChangedPatient << DiagnosisId)
            ]
        , div []
            [ text "Medications"
            , div [] []
            , viewExampleMedications model.patient.exampleMedications
            , newPatientMedicationInputGroup model.medications
                model.newPatientMedication
                (\id name ->
                    ChangedNewPatientMedication (MedicationIdentity id name)
                )
                (ChangedNewPatientMedication << Dose)
                (ChangedNewPatientMedication << Route)
                (ChangedNewPatientMedication << Frequency)
                (ChangedPatient << AddMedication)
            ]
        ]



-- UI


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    input [ type_ t, placeholder p, value v, onInput toMsg ] []


newPatientMedicationInputGroup :
    RemoteData (Dict String String)
    -> Maybe PatientMedication
    -> (String -> String -> msg)
    -> (String -> msg)
    -> (String -> msg)
    -> (String -> msg)
    -> (PatientMedication -> msg)
    -> Html msg
newPatientMedicationInputGroup remoteData maybeNewPatientMedication onChangeMedication onChangeDose onChangeRoute onChangeFrequency onSubmit =
    case remoteData of
        NotAsked ->
            div [] []

        Loading ->
            div [] [ text "Loading" ]

        Failure _ ->
            div [] [ text "Failure" ]

        Success medications ->
            let
                textInputs =
                    case maybeNewPatientMedication of
                        Nothing ->
                            span []
                                [ input [ disabled True, placeholder "Dose" ] []
                                , input
                                    [ disabled True
                                    , placeholder "Route"
                                    ]
                                    []
                                , input
                                    [ disabled True
                                    , placeholder "Frequency"
                                    ]
                                    []
                                , button [ disabled True ] [ text "+" ]
                                ]

                        Just newPatientMedication ->
                            span []
                                [ input
                                    [ type_ "text"
                                    , placeholder "Dose"
                                    , value newPatientMedication.dose
                                    , onInput onChangeDose
                                    ]
                                    []
                                , input
                                    [ type_ "text"
                                    , placeholder "Route"
                                    , value newPatientMedication.route
                                    , onInput onChangeRoute
                                    ]
                                    []
                                , input
                                    [ type_ "text"
                                    , placeholder "Frequency"
                                    , value newPatientMedication.frequency
                                    , onInput onChangeFrequency
                                    ]
                                    []
                                , button [ onClick (onSubmit newPatientMedication) ] [ text "+" ]
                                ]
            in
            div []
                [ medicationSelectInput
                    medications
                    maybeNewPatientMedication
                    onChangeMedication
                , textInputs
                ]


medicationSelectInput :
    Dict String String
    -> Maybe PatientMedication
    -> (String -> String -> msg)
    -> Html msg
medicationSelectInput medications maybeNewPatientMedication toMsg =
    let
        msg medicationId =
            Dict.get medicationId medications
                |> Maybe.withDefault ""
                |> (\name -> toMsg medicationId name)

        selectArgs =
            case maybeNewPatientMedication of
                Just newPatientMedicaiton ->
                    [ value newPatientMedicaiton.medicationId, onInput msg ]

                Nothing ->
                    [ onInput msg ]
    in
    select selectArgs
        (option [ selected True, disabled True ]
            [ text "Select an option" ]
            :: (medications
                |> Dict.toList
                |> List.map (\( k, v ) -> option [ value k ] [ text v ]
                )
            )
        )


diagnosisSelectInput :
    RemoteData (Dict String String)
    -> Maybe String
    -> (String -> msg)
    -> Html msg
diagnosisSelectInput remoteData maybeId toMsg =
    case remoteData of
        NotAsked ->
            div [] []

        Loading ->
            div [] [ text "Loading" ]

        Success dict ->
            let
                selectArgs =
                    case maybeId of
                        Just id ->
                            [ value id, onInput toMsg ]

                        Nothing ->
                            [ onInput toMsg ]
            in
            select selectArgs
                (option [ selected True, disabled True ]
                    [ text "Select an option" ]
                    :: (dict
                            |> Dict.toList
                            |> List.map
                                (\( k, v ) ->
                                    option [ value k ]
                                        [ text v ]
                                )
                       )
                )

        Failure _ ->
            div [] [ text "Failure" ]


viewExampleMedication : PatientMedication -> Html msg
viewExampleMedication { medicationName, dose, route, frequency } =
    div []
        [ text medicationName, text ", ", text dose, text ", ", text route, text ", ", text frequency  ]


viewExampleMedications :
    List PatientMedication
    -> Html msg
viewExampleMedications exampleMedications =
    div []
        (List.map viewExampleMedication exampleMedications)


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
