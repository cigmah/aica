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
    , exampleInvestigations : List PatientInvestigation
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
    , exampleInvestigations = []
    }


type alias PatientMedication =
    { medicationId : String
    , medicationName : String
    , dose : String
    , route : String
    , frequency : String
    }


type alias PatientInvestigation =
    { investigationId : String
    , investigationName : String
    , investigationResult : String
    }


type InvestigationMode
    = Radiology
    | Pathology


type alias Investigation =
    { investigation : String
    , mode : InvestigationMode
    }



-- Custom Definitions
-- APIS


getAll : () -> Cmd Msg
getAll () =
    Cmd.batch [ getDiagnoses (), getInvestigations (), getMedications () ]


getDiagnoses : () -> Cmd Msg
getDiagnoses () =
    Http.get
        { url = "https://aica-cigmah.firebaseio.com/diagnoses.json"
        , expect = Http.expectJson GotDiagnoses diagnosesDecoder
        }


getInvestigations : () -> Cmd Msg
getInvestigations () =
    Http.get
        { url = "https://aica-cigmah.firebaseio.com/investigations.json"
        , expect = Http.expectJson GotInvestigations investigationsDecoder
        }


getMedications : () -> Cmd Msg
getMedications () =
    Http.get
        { url = "https://aica-cigmah.firebaseio.com/medications.json"
        , expect = Http.expectJson GotMedications medicationsDecoder
        }



-- APIS
-- Decoders


{-| Decoder for a diagnosis from Firebase.

The data will look like:

    { "012345668978": { diagnosis: "description" },
      "ABCDEFGHIJKL": { diagnosis: "description" }
    }

-}
diagnosesDecoder : Decoder (Dict String String)
diagnosesDecoder =
    Decode.dict (Decode.field "diagnosis" Decode.string)


modeDecoder : Decoder InvestigationMode
modeDecoder =
    Decode.string
        |> Decode.andThen
            (\s ->
                case s of
                    "radiology" ->
                        Decode.succeed Radiology

                    "pathology" ->
                        Decode.succeed Pathology

                    _ ->
                        Decode.fail "Invalid investigation mode"
            )


{-| Decoder for an investigation from Firebase.

The data will look like:

    { "012345668978": { investigation: "description", mode: "radiology" },
      "ABCDEFGHIJKL": { investigation: "description", mode: "pathology" }
    }

-}
investigationDecoder : Decoder Investigation
investigationDecoder =
    Decode.map2 Investigation
        (Decode.field "investigation" Decode.string)
        (Decode.field "mode" modeDecoder)


investigationsDecoder : Decoder (Dict String Investigation)
investigationsDecoder =
    Decode.dict investigationDecoder


medicationsDecoder : Decoder (Dict String String)
medicationsDecoder =
    Decode.dict (Decode.field "medication" Decode.string)


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


type alias Model =
    { diagnosis : String
    , id : String
    , patient : Patient
    , diagnoses : RemoteData (Dict String String)
    , investigations : RemoteData (Dict String Investigation)
    , medications : RemoteData (Dict String String)
    , newPatientInvestigation : Maybe PatientInvestigation
    , newPatientMedication : Maybe PatientMedication
    }


init : ( Model, Cmd Msg )
init =
    ( { diagnosis = ""
      , id = "Not submitted"
      , patient = defaultPatient
      , diagnoses = Loading
      , investigations = Loading
      , medications = Loading
      , newPatientInvestigation = Nothing
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
    | GotInvestigations (Result Http.Error (Dict String Investigation))
    | GotMedications (Result Http.Error (Dict String String))
    | ChangedNewPatientInvestigation PatientInvestigationField
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
    | AddInvestigation PatientInvestigation
    | DeletedInvestigation PatientInvestigation
    | DeletedMedication PatientMedication


type PatientMedicationField
    = MedicationIdentity String String
    | Dose String
    | Route String
    | Frequency String


type PatientInvestigationField
    = InvestigationIdentity String String
    | InvestigationResult String



-- Messages


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ patient, newPatientInvestigation, newPatientMedication } as model) =
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

                AddInvestigation patientInvestigation ->
                    ( { model
                        | patient =
                            { patient
                                | exampleInvestigations =
                                    append patient.exampleInvestigations
                                        [ patientInvestigation ]
                            }
                        , newPatientInvestigation = Nothing
                      }
                    , Cmd.none
                    )

                DeletedInvestigation patientInvestigation ->
                    ( { model
                        | patient =
                            { patient
                                | exampleInvestigations =
                                    List.filter
                                        (\eI -> eI /= patientInvestigation)
                                        patient.exampleInvestigations
                            }
                      }
                    , Cmd.none
                    )

                DeletedMedication patientMedication ->
                    ( { model
                        | patient =
                            { patient
                                | exampleMedications =
                                    List.filter
                                        (\eM -> eM /= patientMedication)
                                        patient.exampleMedications
                            }
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

        GotInvestigations result ->
            case result of
                Ok investigations ->
                    ( { model | investigations = Success investigations }
                    , Cmd.none
                    )

                Err e ->
                    ( { model | investigations = Failure e }, Cmd.none )

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
                                            , dose = ""
                                            , route = ""
                                            , frequency = ""
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

        ChangedNewPatientInvestigation patientInvestigationField ->
            case newPatientInvestigation of
                Nothing ->
                    case patientInvestigationField of
                        InvestigationIdentity investigationId investigationName ->
                            ( { model
                                | newPatientInvestigation =
                                    Just
                                        { investigationId = investigationId
                                        , investigationName = investigationName
                                        , investigationResult = ""
                                        }
                              }
                            , Cmd.none
                            )

                        _ ->
                            ( model, Cmd.none )

                Just patientInvestigation ->
                    case patientInvestigationField of
                        InvestigationIdentity investigationId investigationName ->
                            ( { model
                                | newPatientInvestigation =
                                    Just
                                        { investigationId = investigationId
                                        , investigationName = investigationName
                                        , investigationResult = ""
                                        }
                              }
                            , Cmd.none
                            )

                        InvestigationResult investigationResult ->
                            ( { model
                                | newPatientInvestigation =
                                    Just
                                        { patientInvestigation
                                            | investigationResult =
                                                investigationResult
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
            , viewExampleMedications
                model.patient.exampleMedications
                (ChangedPatient << DeletedMedication)
            , newPatientMedicationInputGroup
                { remoteData = model.medications
                , maybeNewPatientMedication = model.newPatientMedication
                , onChangeMedication =
                    \id name ->
                        ChangedNewPatientMedication (MedicationIdentity id name)
                , onChangeDose = ChangedNewPatientMedication << Dose
                , onChangeRoute = ChangedNewPatientMedication << Route
                , onChangeFrequency = ChangedNewPatientMedication << Frequency
                , onSubmit = ChangedPatient << AddMedication
                }
            ]
        , div []
            [ text "Investigations"
            , div [] []
            , viewExampleInvestigations
                model.patient.exampleInvestigations
                (ChangedPatient << DeletedInvestigation)
            , newInvestigationInputGroup
                { remoteData = model.investigations
                , maybeNewPatientInvestigation = model.newPatientInvestigation
                , onChangeInvestigation =
                    \id name ->
                        ChangedNewPatientInvestigation
                            (InvestigationIdentity id name)
                , onChangeInvestigationResult =
                    ChangedNewPatientInvestigation << InvestigationResult
                , onSubmit = ChangedPatient << AddInvestigation
                }
            ]
        ]



-- UI


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    input [ type_ t, placeholder p, value v, onInput toMsg ] []


type alias NewInvestigationInputGroupData msg =
    { remoteData : RemoteData (Dict String Investigation)
    , maybeNewPatientInvestigation : Maybe PatientInvestigation
    , onChangeInvestigation : String -> String -> msg
    , onChangeInvestigationResult : String -> msg
    , onSubmit : PatientInvestigation -> msg
    }


newInvestigationInputGroup : NewInvestigationInputGroupData msg -> Html msg
newInvestigationInputGroup { remoteData, maybeNewPatientInvestigation, onChangeInvestigation, onChangeInvestigationResult, onSubmit } =
    case remoteData of
        NotAsked ->
            div [] []

        Loading ->
            div [] [ text "Loading" ]

        Failure _ ->
            div [] [ text "Failure" ]

        Success investigations ->
            let
                textInputs =
                    case maybeNewPatientInvestigation of
                        Nothing ->
                            span []
                                [ input
                                    [ disabled True
                                    , placeholder "Investigation Result"
                                    ]
                                    []
                                , button [ disabled True ] [ text "+" ]
                                ]

                        Just newPatientInvestigation ->
                            span []
                                [ input
                                    [ type_ "text"
                                    , placeholder "Investigation Result"
                                    , value
                                        newPatientInvestigation.investigationResult
                                    , onInput onChangeInvestigationResult
                                    ]
                                    []
                                , button
                                    [ onClick (onSubmit newPatientInvestigation) ]
                                    [ text "+" ]
                                ]
            in
            div []
                [ investigationSelectInput
                    investigations
                    maybeNewPatientInvestigation
                    onChangeInvestigation
                , textInputs
                ]


investigationSelectInput :
    Dict String Investigation
    -> Maybe PatientInvestigation
    -> (String -> String -> msg)
    -> Html msg
investigationSelectInput investgations maybeNewPatientInvestigation toMsg =
    let
        msg investigationId =
            let
                maybeInvestigation =
                    Dict.get investigationId investgations
            in
            case maybeInvestigation of
                Just investigation ->
                    toMsg investigationId investigation.investigation

                Nothing ->
                    toMsg investigationId "error loading investigation"

        selectArgs =
            case maybeNewPatientInvestigation of
                Just newPatientInvestigation ->
                    [ value newPatientInvestigation.investigationId
                    , onInput msg
                    ]

                Nothing ->
                    [ onInput msg ]
    in
    select selectArgs
        (option [ selected True, disabled True ]
            [ text "Select an option" ]
            :: (investgations
                    |> Dict.toList
                    |> List.map
                        (\( k, v ) ->
                            option [ value k ] [ text v.investigation ]
                        )
               )
        )


viewExampleInvestigation : (PatientInvestigation -> msg) -> PatientInvestigation -> Html msg
viewExampleInvestigation onDelete ({ investigationName, investigationResult } as patientInvestigation) =
    div []
        [ text investigationName
        , text ", "
        , text investigationResult
        , button [ onClick (onDelete patientInvestigation) ] [ text "-" ]
        ]


viewExampleInvestigations :
    List PatientInvestigation
    -> (PatientInvestigation -> msg)
    -> Html msg
viewExampleInvestigations exampleInvestigations onDelete =
    div []
        (List.map (viewExampleInvestigation onDelete) exampleInvestigations)


type alias NewMedicationInputGroupData msg =
    { remoteData : RemoteData (Dict String String)
    , maybeNewPatientMedication : Maybe PatientMedication
    , onChangeMedication : String -> String -> msg
    , onChangeDose : String -> msg
    , onChangeRoute : String -> msg
    , onChangeFrequency : String -> msg
    , onSubmit : PatientMedication -> msg
    }


newPatientMedicationInputGroup : NewMedicationInputGroupData msg -> Html msg
newPatientMedicationInputGroup { remoteData, maybeNewPatientMedication, onChangeMedication, onChangeDose, onChangeRoute, onChangeFrequency, onSubmit } =
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
                                , button
                                    [ onClick (onSubmit newPatientMedication) ]
                                    [ text "+" ]
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
                |> Maybe.withDefault "error loading medication"
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
                    |> List.map
                        (\( k, v ) -> option [ value k ] [ text v ])
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


viewExampleMedication : (PatientMedication -> msg) -> PatientMedication -> Html msg
viewExampleMedication onDelete ({ medicationName, dose, route, frequency } as patientInvestigation) =
    div []
        [ text medicationName
        , text ", "
        , text dose
        , text ", "
        , text route
        , text ", "
        , text frequency
        , button [ onClick (onDelete patientInvestigation) ] [ text "-" ]
        ]


viewExampleMedications :
    List PatientMedication
    -> (PatientMedication -> msg)
    -> Html msg
viewExampleMedications exampleMedications onDelete =
    div []
        (List.map (viewExampleMedication onDelete) exampleMedications)



-- UI


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
