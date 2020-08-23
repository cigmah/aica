module Maker.Main exposing (..)

import Browser
import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import List exposing (append)
import Shared.Api as Api exposing (RemoteData(..))
import Shared.Diagnosis as Diagnosis exposing (Diagnosis)
import Shared.Investigation as Investigation exposing (Investigation)
import Shared.Medication as Medication exposing (Medication)
import Shared.Note as Note exposing (Note)
import Shared.Patient as Patient exposing (Patient)
import Shared.Prescription as Prescription exposing (Prescription)
import Shared.Result as Result exposing (Result)
import String exposing (String)



-- | MODEL


type alias Model =
    { -- Backend data
      diagnoses : RemoteData Diagnosis.Index
    , investigations : RemoteData Investigation.Index
    , medications : RemoteData Medication.Index

    -- In-progress additions to backend data
    , newDiagnosis : Diagnosis.InProgress
    , newDiagnosisId : RemoteData String
    , newInvestigation : Investigation.InProgress
    , newInvestigationId : RemoteData String
    , newMedication : Medication.InProgress
    , newMedicationId : RemoteData String

    -- Patient case data
    , patient : Patient.InProgress

    -- UI temporary data containers
    , newPatientResult : Maybe Result
    , newPatientPrescription : Maybe Prescription
    , newPatientPreviousNote : Note
    }


init : () -> ( Model, Cmd Msg )
init () =
    ( { diagnoses = Loading
      , investigations = Loading
      , medications = Loading
      , newDiagnosis = Diagnosis.defaultInProgress
      , newDiagnosisId = NotAsked
      , newInvestigation = Investigation.defaultInProgress
      , newInvestigationId = NotAsked
      , newMedication = Medication.defaultInProgress
      , newMedicationId = NotAsked
      , patient = Patient.defaultInProgress
      , newPatientResult = Nothing
      , newPatientPrescription = Nothing
      , newPatientPreviousNote = Note.default
      }
    , Cmd.batch
        [ Api.getDiagnoses GotDiagnoses
        , Api.getInvestigations GotInvestigations
        , Api.getMedications GotMedications
        ]
    )



-- | MSG


type Msg
    = -- Receiving initial data on load
      GotDiagnoses (RemoteData Diagnosis.Index)
    | GotInvestigations (RemoteData Investigation.Index)
    | GotMedications (RemoteData Medication.Index)
      -- Adding new diagnosis to backend
    | ChangedNewDiagnosisName String
    | SubmittedNewDiagnosis
    | GotDiagnosisId (RemoteData String)
      -- Adding new investigation to backend
    | ChangedNewInvestigationName String
    | ChangedNewInvestigationMode String
    | SubmittedNewInvestigation
    | GotNewInvestigationId (RemoteData String)
      -- Adding new medication to backend
    | ChangedNewMedicationName String
    | SubmittedMedication
    | GotNewMedicationId (RemoteData String)
      -- Editing patient
    | ChangedPatient PatientMsg
    | ChangedNewPatientResult PatientResultMsg
    | ChangedNewPatientPrescription PatientPrescriptionMsg
    | ChangedNewPreviousNote PreviousNoteMsg


type PatientMsg
    = ChangedFirstName String
    | ChangedMiddleName String
    | ChangedLastName String
    | ChangedDob String
    | ChangedVisitDateTime String
    | ChangedUrn String
    | ChangedStem String
    | AddedPreviousNote Note
    | DeletedPreviousNote Note
    | ChangedExplanation String
    | ChangedExampleNote String
    | SelectedDiagnosis Diagnosis
    | AddedResult Result
    | DeletedResult Result
    | AddedPrescription Prescription
    | DeletedPrescription Prescription


type PatientPrescriptionMsg
    = ChangedMedication String String
    | ChangedDose String
    | ChangedRoute String
    | ChangedFrequency String


type PatientResultMsg
    = ChangedInvestigation String String
    | ChangedResult String


type PreviousNoteMsg
    = ChangedBrief String
    | ChangedFull String



-- | UPDATE


withCmdNone : Model -> ( Model, Cmd Msg )
withCmdNone model =
    ( model, Cmd.none )


withCmd : Cmd Msg -> Model -> ( Model, Cmd Msg )
withCmd cmd model =
    ( model, cmd )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ newDiagnosis, newInvestigation, newMedication } as model) =
    let
        -- Temporary ignore only
        todo =
            ( model, Cmd.none )
    in
    case msg of
        -- Receiving initial data on load
        GotDiagnoses remoteData ->
            { model | diagnoses = remoteData }
                |> withCmdNone

        GotInvestigations remoteData ->
            { model | investigations = remoteData }
                |> withCmdNone

        GotMedications remoteData ->
            { model | medications = remoteData }
                |> withCmdNone

        -- Adding new diagnosis to backend
        ChangedNewDiagnosisName string ->
            { model | newDiagnosis = { newDiagnosis | name = string } }
                |> withCmdNone

        SubmittedNewDiagnosis ->
            if (model.newDiagnosis.name |> String.trim |> String.length) >= 3 then
                { model | newDiagnosisId = Loading }
                    |> withCmd (Api.postDiagnosis model.newDiagnosis GotDiagnosisId)

            else
                todo

        GotDiagnosisId remoteData ->
            { model | newDiagnosisId = remoteData }
                |> withCmdNone

        ChangedNewInvestigationName string ->
            todo

        ChangedNewInvestigationMode string ->
            todo

        SubmittedNewInvestigation ->
            todo

        GotNewInvestigationId string ->
            todo

        ChangedNewMedicationName string ->
            todo

        SubmittedMedication ->
            todo

        GotNewMedicationId string ->
            todo

        -- Editing patient
        ChangedPatient patientMsg ->
            updatePatient patientMsg model

        ChangedNewPatientResult resultMsg ->
            updateNewPatientResult resultMsg model

        ChangedNewPatientPrescription prescriptionMsg ->
            updateNewPatientPrescription prescriptionMsg model

        ChangedNewPreviousNote previousNoteMsg ->
            updateNewPreviousNote previousNoteMsg model


updatePatient : PatientMsg -> Model -> ( Model, Cmd Msg )
updatePatient msg ({ patient, newPatientPreviousNote } as model) =
    let
        todo =
            ( model, Cmd.none )
    in
    case msg of
        ChangedFirstName string ->
            { model | patient = { patient | firstName = string } }
                |> withCmdNone

        ChangedMiddleName string ->
            { model | patient = { patient | middleName = string } }
                |> withCmdNone

        ChangedLastName string ->
            { model | patient = { patient | lastName = string } }
                |> withCmdNone

        ChangedDob string ->
            { model | patient = { patient | dob = string } }
                |> withCmdNone

        ChangedVisitDateTime string ->
            { model | patient = { patient | visitDateTime = string } }
                |> withCmdNone

        ChangedUrn string ->
            { model | patient = { patient | urn = string } }
                |> withCmdNone

        ChangedStem string ->
            { model | patient = { patient | stem = string } }
                |> withCmdNone

        AddedPreviousNote note ->
            { model
                | patient = { patient | previousNotes = newPatientPreviousNote :: patient.previousNotes }
                , newPatientPreviousNote = Note.default
            }
                |> withCmdNone

        DeletedPreviousNote note ->
            todo

        ChangedExplanation string ->
            { model | patient = { patient | explanation = string } }
                |> withCmdNone

        ChangedExampleNote string ->
            { model | patient = { patient | exampleNote = string } }
                |> withCmdNone

        SelectedDiagnosis diagnosis ->
            { model | patient = { patient | exampleDiagnosis = Just diagnosis } }
                |> withCmdNone

        AddedResult result ->
            if List.member result.investigation (List.map .investigation patient.exampleResults) then
                todo

            else
                { model
                    | patient = { patient | exampleResults = result :: patient.exampleResults }
                    , newPatientResult = Nothing
                }
                    |> withCmdNone

        DeletedResult result ->
            { model
                | patient = { patient | exampleResults = List.filter (\x -> x /= result) patient.exampleResults }
            }
                |> withCmdNone

        AddedPrescription prescription ->
            todo

        DeletedPrescription prescription ->
            todo


updateNewPatientPrescription : PatientPrescriptionMsg -> Model -> ( Model, Cmd Msg )
updateNewPatientPrescription msg ({ newPatientPrescription } as model) =
    let
        todo =
            ( model, Cmd.none )
    in
    case newPatientPrescription of
        Nothing ->
            case msg of
                ChangedMedication id name ->
                    { model | newPatientPrescription = Just (Prescription.withDefaults id name) }
                        |> withCmdNone

                _ ->
                    todo

        Just prescription ->
            case msg of
                ChangedMedication id name ->
                    { model | newPatientPrescription = Just { prescription | medication = { id = id, name = name } } }
                        |> withCmdNone

                ChangedDose string ->
                    { model | newPatientPrescription = Just { prescription | dose = string } }
                        |> withCmdNone

                ChangedFrequency string ->
                    { model | newPatientPrescription = Just { prescription | frequency = string } }
                        |> withCmdNone

                ChangedRoute string ->
                    { model | newPatientPrescription = Just { prescription | route = string } }
                        |> withCmdNone


updateNewPatientResult : PatientResultMsg -> Model -> ( Model, Cmd Msg )
updateNewPatientResult msg model =
    let
        todo =
            ( model, Cmd.none )
    in
    case msg of
        ChangedInvestigation id name ->
            todo

        ChangedResult string ->
            todo


updateNewPreviousNote : PreviousNoteMsg -> Model -> ( Model, Cmd Msg )
updateNewPreviousNote msg model =
    let
        todo =
            ( model, Cmd.none )
    in
    case msg of
        ChangedBrief string ->
            todo

        ChangedFull string ->
            todo



-- | SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- | VIEW


tailwind : String -> Attribute msg
tailwind =
    class


view : Model -> Html Msg
view model =
    div [] []



{-

   view : Model -> Html Msg
   view model =
       section [ id "container", tailwind "w-full bg-gray-200 min-h-screen p-8" ]
           [ article [ id "form", tailwind "bg-white mx-auto max-w-5xl p-8 min-w-lg shadow-lg rounded-lg" ]
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
                   , viewExampleMedications
                       model.patient.exampleMedications
                       (ChangedPatient << DeletedMedication)
                   ]
               , div []
                   [ text "Investigations"
                   , div [] []
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
                   , viewExampleInvestigations
                       model.patient.exampleInvestigations
                       (ChangedPatient << DeletedInvestigation)
                   ]
               , div []
                   [ text "Previous Notes"
                   , div [] []
                   , input
                       [ type_ "text"
                       , onInput (ChangedNewPreviousNote << NoteBrief)
                       , placeholder "Note brief"
                       , value model.newPreviousNote.brief
                       ]
                       []
                   , textarea
                       [ onInput (ChangedNewPreviousNote << Note)
                       , placeholder "Note"
                       , value model.newPreviousNote.full
                       ]
                       []
                   , button
                       [ onClick
                           ((ChangedPatient << AddPreviousNote)
                               model.newPreviousNote
                           )
                       ]
                       [ text "+" ]
                   , viewPreviousNotes
                       model.patient.previousNotes
                       (ChangedPatient << DeletedPreviousNote)
                   ]
               ]
           ]



   -- UI


   viewInput : String -> String -> String -> (String -> msg) -> Html msg
   viewInput t p v toMsg =
       input [ type_ t, placeholder p, value v, onInput toMsg ] []


   type alias NewInvestigationInputGroupData msg =
       { remoteData : RemoteData (Dict String Investigation)
       , maybeNewPatientInvestigation : Maybe Investigation
       , onChangeInvestigation : String -> String -> msg
       , onChangeInvestigationResult : String -> msg
       , onSubmit : Investigation -> msg
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
                                           newPatientInvestigation.result
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
       -> Maybe Investigation
       -> (String -> String -> msg)
       -> Html msg
   investigationSelectInput investgations maybeNewPatientInvestigation toMsg =
       let
           msg id =
               let
                   maybeInvestigation =
                       Dict.get id investgations
               in
               case maybeInvestigation of
                   Just investigation ->
                       toMsg id investigation.investigation

                   Nothing ->
                       toMsg id "error loading investigation"

           selectArgs =
               case maybeNewPatientInvestigation of
                   Just newPatientInvestigation ->
                       [ value newPatientInvestigation.id
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


   viewExampleInvestigation : (Investigation -> msg) -> Investigation -> Html msg
   viewExampleInvestigation onDelete ({ name, result } as patientInvestigation) =
       div []
           [ text name
           , text " | "
           , text result
           , button [ onClick (onDelete patientInvestigation) ] [ text "-" ]
           ]


   viewExampleInvestigations :
       List Investigation
       -> (Investigation -> msg)
       -> Html msg
   viewExampleInvestigations exampleInvestigations onDelete =
       div []
           (List.map (viewExampleInvestigation onDelete) exampleInvestigations)


   type alias NewMedicationInputGroupData msg =
       { remoteData : RemoteData (Dict String String)
       , maybeNewPatientMedication : Maybe Medication
       , onChangeMedication : String -> String -> msg
       , onChangeDose : String -> msg
       , onChangeRoute : String -> msg
       , onChangeFrequency : String -> msg
       , onSubmit : Medication -> msg
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
       -> Maybe Medication
       -> (String -> String -> msg)
       -> Html msg
   medicationSelectInput medications maybeNewPatientMedication toMsg =
       let
           msg id =
               Dict.get id medications
                   |> Maybe.withDefault "error loading medication"
                   |> (\name -> toMsg id name)

           selectArgs =
               case maybeNewPatientMedication of
                   Just newPatientMedicaiton ->
                       [ value newPatientMedicaiton.id, onInput msg ]

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


   viewExampleMedication : (Medication -> msg) -> Medication -> Html msg
   viewExampleMedication onDelete ({ name, dose, route, frequency } as patientInvestigation) =
       div []
           [ text name
           , text " | "
           , text dose
           , text " | "
           , text route
           , text " | "
           , text frequency
           , button [ onClick (onDelete patientInvestigation) ] [ text "-" ]
           ]


   viewExampleMedications :
       List Medication
       -> (Medication -> msg)
       -> Html msg
   viewExampleMedications exampleMedications onDelete =
       div []
           (List.map (viewExampleMedication onDelete) exampleMedications)


   viewPreviousNote : (Note -> msg) -> Note -> Html msg
   viewPreviousNote onDelete ({ brief, full } as previousNote) =
       div []
           [ text brief
           , text " | "
           , text full
           , button [ onClick (onDelete previousNote) ] [ text "-" ]
           ]


   viewPreviousNotes : List Note -> (Note -> msg) -> Html msg
   viewPreviousNotes previousNotes onDelete =
       div []
           (List.map (viewPreviousNote onDelete) previousNotes)

-}
