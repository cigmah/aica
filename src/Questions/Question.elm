module Questions.Question exposing (..)

import Option
import Questions.Alcohol as Alcohol exposing (..)
import Questions.Details as Details exposing (..)
import Questions.Drugs as Drugs exposing (..)
import Questions.Examine as Examine exposing (..)
import Questions.Feelings as Feelings exposing (..)
import Questions.Fhx as Fhx exposing (..)
import Questions.LocFeature as LocFeature exposing (..)
import Questions.Open as Open exposing (..)
import Questions.PainFeature as PainFeature exposing (..)
import Questions.Phx as Phx exposing (..)
import Questions.RashFeature as RashFeature exposing (..)
import Questions.SeizureFeature as SeizureFeature exposing (..)
import Questions.Shx as Shx exposing (..)
import Questions.Sign as Sign exposing (..)
import Questions.Smoke as Smoke exposing (..)
import Questions.SputumFeature as SputumFeature exposing (..)
import Questions.Symptom as Symptom exposing (..)
import Questions.SymptomFeature as SymptomFeature exposing (..)


type Question
    = QuestionDetails Details
    | QuestionOpen Open
    | QuestionPainFeature PainFeature
    | QuestionSymptomFeature SymptomFeature
    | QuestionFeelings Feelings
    | QuestionSymptom Symptom
    | QuestionRashFeature RashFeature
    | QuestionExamine Examine
    | QuestionLocFeature LocFeature
    | QuestionSeizureFeature SeizureFeature
    | QuestionSputumFeature SputumFeature
    | QuestionPhx Phx
    | QuestionDrugs Drugs
    | QuestionAlcohol Alcohol
    | QuestionSmoke Smoke
    | QuestionFhx Fhx
    | QuestionShx Shx
    | QuestionSign Sign


fromInt : Int -> Question
fromInt int =
    case int of
        0 ->
            QuestionDetails Details.Name

        1 ->
            QuestionDetails Details.Age

        2 ->
            QuestionDetails Details.OccupationBrief

        3 ->
            QuestionDetails Details.OccupationDescription

        4 ->
            QuestionOpen Open.Opening

        5 ->
            QuestionOpen Open.Symptoms

        6 ->
            QuestionOpen Open.Phx

        7 ->
            QuestionOpen Open.Fhx

        8 ->
            QuestionPainFeature PainFeature.Where

        9 ->
            QuestionPainFeature PainFeature.Side

        10 ->
            QuestionPainFeature PainFeature.Onset

        11 ->
            QuestionPainFeature PainFeature.Timing

        12 ->
            QuestionPainFeature PainFeature.Quality

        13 ->
            QuestionPainFeature PainFeature.Quantity

        14 ->
            QuestionPainFeature PainFeature.Before

        15 ->
            QuestionPainFeature PainFeature.Triggers

        16 ->
            QuestionPainFeature PainFeature.Radiation

        17 ->
            QuestionSymptomFeature SymptomFeature.Where

        18 ->
            QuestionSymptomFeature SymptomFeature.Quantity

        19 ->
            QuestionSymptomFeature SymptomFeature.Alleviating

        20 ->
            QuestionSymptomFeature SymptomFeature.Aggravating

        21 ->
            QuestionFeelings Feelings.Beliefs

        22 ->
            QuestionFeelings Feelings.Impact

        23 ->
            QuestionFeelings Feelings.Expectations

        24 ->
            QuestionFeelings Feelings.Concerns

        25 ->
            QuestionSymptom Symptom.Pain

        26 ->
            QuestionSymptom Symptom.Nausea

        27 ->
            QuestionSymptom Symptom.Vomiting

        28 ->
            QuestionSymptom Symptom.NeckStiff

        29 ->
            QuestionSymptom Symptom.Diplopia

        30 ->
            QuestionSymptom Symptom.VisualChange

        31 ->
            QuestionSymptom Symptom.Photophobia

        32 ->
            QuestionSymptom Symptom.Rhinorrhoea

        33 ->
            QuestionSymptom Symptom.Cough

        34 ->
            QuestionSymptom Symptom.Headache

        35 ->
            QuestionSymptom Symptom.Lacrimation

        36 ->
            QuestionSymptom Symptom.RecentlyIll

        37 ->
            QuestionSymptom Symptom.SickContact

        38 ->
            QuestionSymptom Symptom.Fever

        39 ->
            QuestionSymptom Symptom.Rash

        40 ->
            QuestionSymptom Symptom.ChestPain

        41 ->
            QuestionSymptom Symptom.Dyspnoea

        42 ->
            QuestionSymptom Symptom.Palpitations

        43 ->
            QuestionSymptom Symptom.AnkleSwelling

        44 ->
            QuestionSymptom Symptom.IntermittentClaudication

        45 ->
            QuestionSymptom Symptom.Orthopnoea

        46 ->
            QuestionSymptom Symptom.Pnd

        47 ->
            QuestionSymptom Symptom.Loc

        48 ->
            QuestionSymptom Symptom.Seizure

        49 ->
            QuestionSymptom Symptom.Fatigue

        50 ->
            QuestionSymptom Symptom.Haemoptysis

        51 ->
            QuestionSymptom Symptom.Sputum

        52 ->
            QuestionSymptom Symptom.SoreThroat

        53 ->
            QuestionSymptom Symptom.Diaphoresis

        54 ->
            QuestionSymptom Symptom.JawClaudication

        55 ->
            QuestionSymptom Symptom.VIsualChange

        56 ->
            QuestionRashFeature RashFeature.Where

        57 ->
            QuestionExamine Examine.Rash

        58 ->
            QuestionExamine Examine.Hands

        59 ->
            QuestionExamine Examine.General

        60 ->
            QuestionExamine Examine.Vitals

        61 ->
            QuestionExamine Examine.Weight

        62 ->
            QuestionExamine Examine.Surroundings

        63 ->
            QuestionExamine Examine.Nails

        64 ->
            QuestionExamine Examine.Arms

        65 ->
            QuestionExamine Examine.EyeMovements

        66 ->
            QuestionExamine Examine.VisualFields

        67 ->
            QuestionExamine Examine.HandMovements

        68 ->
            QuestionExamine Examine.Fundus

        69 ->
            QuestionExamine Examine.Snellen

        70 ->
            QuestionExamine Examine.Pupils

        71 ->
            QuestionExamine Examine.FacialExpression

        72 ->
            QuestionExamine Examine.Mastication

        73 ->
            QuestionExamine Examine.Tongue

        74 ->
            QuestionExamine Examine.OralMucosa

        75 ->
            QuestionExamine Examine.HeartAuscultate

        76 ->
            QuestionExamine Examine.LungsAuscultate

        77 ->
            QuestionExamine Examine.LungsPercussion

        78 ->
            QuestionExamine Examine.Chest

        79 ->
            QuestionExamine Examine.Neck

        80 ->
            QuestionExamine Examine.PowerArms

        81 ->
            QuestionExamine Examine.PowerLegs

        82 ->
            QuestionExamine Examine.SensationArms

        83 ->
            QuestionExamine Examine.SensationLegs

        84 ->
            QuestionExamine Examine.MentalState

        85 ->
            QuestionLocFeature LocFeature.When

        86 ->
            QuestionSeizureFeature SeizureFeature.Before

        87 ->
            QuestionSputumFeature SputumFeature.Volume

        88 ->
            QuestionSputumFeature SputumFeature.Colour

        89 ->
            QuestionPhx Phx.Hypertension

        90 ->
            QuestionPhx Phx.Diabetes

        91 ->
            QuestionPhx Phx.Surgery

        92 ->
            QuestionPhx Phx.Immunisation

        93 ->
            QuestionDrugs Drugs.Regular

        94 ->
            QuestionDrugs Drugs.Otc

        95 ->
            QuestionDrugs Drugs.Recreational

        96 ->
            QuestionDrugs Drugs.Allergies

        97 ->
            QuestionAlcohol Alcohol.YesNo

        98 ->
            QuestionAlcohol Alcohol.Quantity

        99 ->
            QuestionSmoke Smoke.YesNo

        100 ->
            QuestionSmoke Smoke.Duration

        101 ->
            QuestionSmoke Smoke.History

        102 ->
            QuestionSmoke Smoke.Quantity

        103 ->
            QuestionFhx Fhx.ParentHealth

        104 ->
            QuestionFhx Fhx.Children

        105 ->
            QuestionFhx Fhx.ChildrenHealth

        106 ->
            QuestionFhx Fhx.Siblings

        107 ->
            QuestionFhx Fhx.SiblingsHealth

        108 ->
            QuestionShx Shx.LivingPlace

        109 ->
            QuestionShx Shx.LivingPeople

        110 ->
            QuestionShx Shx.Mood

        111 ->
            QuestionShx Shx.Diet

        112 ->
            QuestionShx Shx.PhysicalExercise

        113 ->
            QuestionShx Shx.Driving

        114 ->
            QuestionSign Sign.Brudzinski

        115 ->
            QuestionSign Sign.Papilloedema

        116 ->
            QuestionSign Sign.Kernig

        117 ->
            QuestionSign Sign.PeripheralCyanosis

        118 ->
            QuestionSign Sign.CentralCyanosis

        119 ->
            QuestionSign Sign.CarotidBruits

        120 ->
            QuestionSign Sign.Dysdiado

        121 ->
            QuestionSign Sign.IntentionTremo

        _ ->
            QuestionDetails Details.Name


toInt : Question -> Int
toInt enum =
    case enum of
        QuestionDetails Details.Name ->
            0

        QuestionDetails Details.Age ->
            1

        QuestionDetails Details.OccupationBrief ->
            2

        QuestionDetails Details.OccupationDescription ->
            3

        QuestionOpen Open.Opening ->
            4

        QuestionOpen Open.Symptoms ->
            5

        QuestionOpen Open.Phx ->
            6

        QuestionOpen Open.Fhx ->
            7

        QuestionPainFeature PainFeature.Where ->
            8

        QuestionPainFeature PainFeature.Side ->
            9

        QuestionPainFeature PainFeature.Onset ->
            10

        QuestionPainFeature PainFeature.Timing ->
            11

        QuestionPainFeature PainFeature.Quality ->
            12

        QuestionPainFeature PainFeature.Quantity ->
            13

        QuestionPainFeature PainFeature.Before ->
            14

        QuestionPainFeature PainFeature.Triggers ->
            15

        QuestionPainFeature PainFeature.Radiation ->
            16

        QuestionSymptomFeature SymptomFeature.Where ->
            17

        QuestionSymptomFeature SymptomFeature.Quantity ->
            18

        QuestionSymptomFeature SymptomFeature.Alleviating ->
            19

        QuestionSymptomFeature SymptomFeature.Aggravating ->
            20

        QuestionFeelings Feelings.Beliefs ->
            21

        QuestionFeelings Feelings.Impact ->
            22

        QuestionFeelings Feelings.Expectations ->
            23

        QuestionFeelings Feelings.Concerns ->
            24

        QuestionSymptom Symptom.Pain ->
            25

        QuestionSymptom Symptom.Nausea ->
            26

        QuestionSymptom Symptom.Vomiting ->
            27

        QuestionSymptom Symptom.NeckStiff ->
            28

        QuestionSymptom Symptom.Diplopia ->
            29

        QuestionSymptom Symptom.VisualChange ->
            30

        QuestionSymptom Symptom.Photophobia ->
            31

        QuestionSymptom Symptom.Rhinorrhoea ->
            32

        QuestionSymptom Symptom.Cough ->
            33

        QuestionSymptom Symptom.Headache ->
            34

        QuestionSymptom Symptom.Lacrimation ->
            35

        QuestionSymptom Symptom.RecentlyIll ->
            36

        QuestionSymptom Symptom.SickContact ->
            37

        QuestionSymptom Symptom.Fever ->
            38

        QuestionSymptom Symptom.Rash ->
            39

        QuestionSymptom Symptom.ChestPain ->
            40

        QuestionSymptom Symptom.Dyspnoea ->
            41

        QuestionSymptom Symptom.Palpitations ->
            42

        QuestionSymptom Symptom.AnkleSwelling ->
            43

        QuestionSymptom Symptom.IntermittentClaudication ->
            44

        QuestionSymptom Symptom.Orthopnoea ->
            45

        QuestionSymptom Symptom.Pnd ->
            46

        QuestionSymptom Symptom.Loc ->
            47

        QuestionSymptom Symptom.Seizure ->
            48

        QuestionSymptom Symptom.Fatigue ->
            49

        QuestionSymptom Symptom.Haemoptysis ->
            50

        QuestionSymptom Symptom.Sputum ->
            51

        QuestionSymptom Symptom.SoreThroat ->
            52

        QuestionSymptom Symptom.Diaphoresis ->
            53

        QuestionSymptom Symptom.JawClaudication ->
            54

        QuestionSymptom Symptom.VIsualChange ->
            55

        QuestionRashFeature RashFeature.Where ->
            56

        QuestionExamine Examine.Rash ->
            57

        QuestionExamine Examine.Hands ->
            58

        QuestionExamine Examine.General ->
            59

        QuestionExamine Examine.Vitals ->
            60

        QuestionExamine Examine.Weight ->
            61

        QuestionExamine Examine.Surroundings ->
            62

        QuestionExamine Examine.Nails ->
            63

        QuestionExamine Examine.Arms ->
            64

        QuestionExamine Examine.EyeMovements ->
            65

        QuestionExamine Examine.VisualFields ->
            66

        QuestionExamine Examine.HandMovements ->
            67

        QuestionExamine Examine.Fundus ->
            68

        QuestionExamine Examine.Snellen ->
            69

        QuestionExamine Examine.Pupils ->
            70

        QuestionExamine Examine.FacialExpression ->
            71

        QuestionExamine Examine.Mastication ->
            72

        QuestionExamine Examine.Tongue ->
            73

        QuestionExamine Examine.OralMucosa ->
            74

        QuestionExamine Examine.HeartAuscultate ->
            75

        QuestionExamine Examine.LungsAuscultate ->
            76

        QuestionExamine Examine.LungsPercussion ->
            77

        QuestionExamine Examine.Chest ->
            78

        QuestionExamine Examine.Neck ->
            79

        QuestionExamine Examine.PowerArms ->
            80

        QuestionExamine Examine.PowerLegs ->
            81

        QuestionExamine Examine.SensationArms ->
            82

        QuestionExamine Examine.SensationLegs ->
            83

        QuestionExamine Examine.MentalState ->
            84

        QuestionLocFeature LocFeature.When ->
            85

        QuestionSeizureFeature SeizureFeature.Before ->
            86

        QuestionSputumFeature SputumFeature.Volume ->
            87

        QuestionSputumFeature SputumFeature.Colour ->
            88

        QuestionPhx Phx.Hypertension ->
            89

        QuestionPhx Phx.Diabetes ->
            90

        QuestionPhx Phx.Surgery ->
            91

        QuestionPhx Phx.Immunisation ->
            92

        QuestionDrugs Drugs.Regular ->
            93

        QuestionDrugs Drugs.Otc ->
            94

        QuestionDrugs Drugs.Recreational ->
            95

        QuestionDrugs Drugs.Allergies ->
            96

        QuestionAlcohol Alcohol.YesNo ->
            97

        QuestionAlcohol Alcohol.Quantity ->
            98

        QuestionSmoke Smoke.YesNo ->
            99

        QuestionSmoke Smoke.Duration ->
            100

        QuestionSmoke Smoke.History ->
            101

        QuestionSmoke Smoke.Quantity ->
            102

        QuestionFhx Fhx.ParentHealth ->
            103

        QuestionFhx Fhx.Children ->
            104

        QuestionFhx Fhx.ChildrenHealth ->
            105

        QuestionFhx Fhx.Siblings ->
            106

        QuestionFhx Fhx.SiblingsHealth ->
            107

        QuestionShx Shx.LivingPlace ->
            108

        QuestionShx Shx.LivingPeople ->
            109

        QuestionShx Shx.Mood ->
            110

        QuestionShx Shx.Diet ->
            111

        QuestionShx Shx.PhysicalExercise ->
            112

        QuestionShx Shx.Driving ->
            113

        QuestionSign Sign.Brudzinski ->
            114

        QuestionSign Sign.Papilloedema ->
            115

        QuestionSign Sign.Kernig ->
            116

        QuestionSign Sign.PeripheralCyanosis ->
            117

        QuestionSign Sign.CentralCyanosis ->
            118

        QuestionSign Sign.CarotidBruits ->
            119

        QuestionSign Sign.Dysdiado ->
            120

        QuestionSign Sign.IntentionTremo ->
            121


toString : Question -> String
toString enum =
    case enum of
        QuestionDetails Details.Name ->
            "Name"

        QuestionDetails Details.Age ->
            "Age"

        QuestionDetails Details.OccupationBrief ->
            "Age"

        QuestionDetails Details.OccupationDescription ->
            "OccupationBrief"

        QuestionOpen Open.Opening ->
            "OccupationDescription"

        QuestionOpen Open.Symptoms ->
            "Opening"

        QuestionOpen Open.Phx ->
            "Opening"

        QuestionOpen Open.Fhx ->
            "Opening"

        QuestionPainFeature PainFeature.Where ->
            "Symptoms"

        QuestionPainFeature PainFeature.Side ->
            "Phx"

        QuestionPainFeature PainFeature.Onset ->
            "Fhx"

        QuestionPainFeature PainFeature.Timing ->
            "Where"

        QuestionPainFeature PainFeature.Quality ->
            "Side"

        QuestionPainFeature PainFeature.Quantity ->
            "Onset"

        QuestionPainFeature PainFeature.Before ->
            "Timing"

        QuestionPainFeature PainFeature.Triggers ->
            "Quality"

        QuestionPainFeature PainFeature.Radiation ->
            "Quantity"

        QuestionSymptomFeature SymptomFeature.Where ->
            "Before"

        QuestionSymptomFeature SymptomFeature.Quantity ->
            "Triggers"

        QuestionSymptomFeature SymptomFeature.Alleviating ->
            "Radiation"

        QuestionSymptomFeature SymptomFeature.Aggravating ->
            "Where"

        QuestionFeelings Feelings.Beliefs ->
            "Quantity"

        QuestionFeelings Feelings.Impact ->
            "Alleviating"

        QuestionFeelings Feelings.Expectations ->
            "Aggravating"

        QuestionFeelings Feelings.Concerns ->
            "Beliefs"

        QuestionSymptom Symptom.Pain ->
            "Impact"

        QuestionSymptom Symptom.Nausea ->
            "Expectations"

        QuestionSymptom Symptom.Vomiting ->
            "Concerns"

        QuestionSymptom Symptom.NeckStiff ->
            "Pain"

        QuestionSymptom Symptom.Diplopia ->
            "Nausea"

        QuestionSymptom Symptom.VisualChange ->
            "Vomiting"

        QuestionSymptom Symptom.Photophobia ->
            "NeckStiff"

        QuestionSymptom Symptom.Rhinorrhoea ->
            "Diplopia"

        QuestionSymptom Symptom.Cough ->
            "VisualChange"

        QuestionSymptom Symptom.Headache ->
            "Photophobia"

        QuestionSymptom Symptom.Lacrimation ->
            "Rhinorrhoea"

        QuestionSymptom Symptom.RecentlyIll ->
            "Cough"

        QuestionSymptom Symptom.SickContact ->
            "Headache"

        QuestionSymptom Symptom.Fever ->
            "Lacrimation"

        QuestionSymptom Symptom.Rash ->
            "RecentlyIll"

        QuestionSymptom Symptom.ChestPain ->
            "SickContact"

        QuestionSymptom Symptom.Dyspnoea ->
            "SickContact"

        QuestionSymptom Symptom.Palpitations ->
            "Fever"

        QuestionSymptom Symptom.AnkleSwelling ->
            "Rash"

        QuestionSymptom Symptom.IntermittentClaudication ->
            "ChestPain"

        QuestionSymptom Symptom.Orthopnoea ->
            "Dyspnoea"

        QuestionSymptom Symptom.Pnd ->
            "Palpitations"

        QuestionSymptom Symptom.Loc ->
            "AnkleSwelling"

        QuestionSymptom Symptom.Seizure ->
            "IntermittentClaudication"

        QuestionSymptom Symptom.Fatigue ->
            "Orthopnoea"

        QuestionSymptom Symptom.Haemoptysis ->
            "Pnd"

        QuestionSymptom Symptom.Sputum ->
            "Loc"

        QuestionSymptom Symptom.SoreThroat ->
            "Loc"

        QuestionSymptom Symptom.Diaphoresis ->
            "Seizure"

        QuestionSymptom Symptom.JawClaudication ->
            "Fatigue"

        QuestionSymptom Symptom.VIsualChange ->
            "Fatigue"

        QuestionRashFeature RashFeature.Where ->
            "Haemoptysis"

        QuestionExamine Examine.Rash ->
            "Sputum"

        QuestionExamine Examine.Hands ->
            "SoreThroat"

        QuestionExamine Examine.General ->
            "Diaphoresis"

        QuestionExamine Examine.Vitals ->
            "JawClaudication"

        QuestionExamine Examine.Weight ->
            "VIsualChange"

        QuestionExamine Examine.Surroundings ->
            "Where"

        QuestionExamine Examine.Nails ->
            "Rash"

        QuestionExamine Examine.Arms ->
            "Hands"

        QuestionExamine Examine.EyeMovements ->
            "General"

        QuestionExamine Examine.VisualFields ->
            "Vitals"

        QuestionExamine Examine.HandMovements ->
            "Weight"

        QuestionExamine Examine.Fundus ->
            "Surroundings"

        QuestionExamine Examine.Snellen ->
            "Nails"

        QuestionExamine Examine.Pupils ->
            "Arms"

        QuestionExamine Examine.FacialExpression ->
            "EyeMovements"

        QuestionExamine Examine.Mastication ->
            "VisualFields"

        QuestionExamine Examine.Tongue ->
            "HandMovements"

        QuestionExamine Examine.OralMucosa ->
            "Fundus"

        QuestionExamine Examine.HeartAuscultate ->
            "Snellen"

        QuestionExamine Examine.LungsAuscultate ->
            "Pupils"

        QuestionExamine Examine.LungsPercussion ->
            "FacialExpression"

        QuestionExamine Examine.Chest ->
            "Mastication"

        QuestionExamine Examine.Neck ->
            "Tongue"

        QuestionExamine Examine.PowerArms ->
            "OralMucosa"

        QuestionExamine Examine.PowerLegs ->
            "HeartAuscultate"

        QuestionExamine Examine.SensationArms ->
            "LungsAuscultate"

        QuestionExamine Examine.SensationLegs ->
            "LungsPercussion"

        QuestionExamine Examine.MentalState ->
            "Chest"

        QuestionLocFeature LocFeature.When ->
            "Neck"

        QuestionSeizureFeature SeizureFeature.Before ->
            "PowerArms"

        QuestionSputumFeature SputumFeature.Volume ->
            "PowerLegs"

        QuestionSputumFeature SputumFeature.Colour ->
            "SensationArms"

        QuestionPhx Phx.Hypertension ->
            "SensationLegs"

        QuestionPhx Phx.Diabetes ->
            "MentalState"

        QuestionPhx Phx.Surgery ->
            "When"

        QuestionPhx Phx.Immunisation ->
            "Before"

        QuestionDrugs Drugs.Regular ->
            "Volume"

        QuestionDrugs Drugs.Otc ->
            "Colour"

        QuestionDrugs Drugs.Recreational ->
            "Hypertension"

        QuestionDrugs Drugs.Allergies ->
            "Diabetes"

        QuestionAlcohol Alcohol.YesNo ->
            "Surgery"

        QuestionAlcohol Alcohol.Quantity ->
            "Immunisation"

        QuestionSmoke Smoke.YesNo ->
            "Regular"

        QuestionSmoke Smoke.Duration ->
            "Otc"

        QuestionSmoke Smoke.History ->
            "Recreational"

        QuestionSmoke Smoke.Quantity ->
            "Allergies"

        QuestionFhx Fhx.ParentHealth ->
            "YesNo"

        QuestionFhx Fhx.Children ->
            "Quantity"

        QuestionFhx Fhx.ChildrenHealth ->
            "YesNo"

        QuestionFhx Fhx.Siblings ->
            "Duration"

        QuestionFhx Fhx.SiblingsHealth ->
            "History"

        QuestionShx Shx.LivingPlace ->
            "Quantity"

        QuestionShx Shx.LivingPeople ->
            "ParentHealth"

        QuestionShx Shx.Mood ->
            "Children"

        QuestionShx Shx.Diet ->
            "ChildrenHealth"

        QuestionShx Shx.PhysicalExercise ->
            "Siblings"

        QuestionShx Shx.Driving ->
            "SiblingsHealth"

        QuestionSign Sign.Brudzinski ->
            "LivingPlace"

        QuestionSign Sign.Papilloedema ->
            "LivingPeople"

        QuestionSign Sign.Kernig ->
            "LivingPeople"

        QuestionSign Sign.PeripheralCyanosis ->
            "Mood"

        QuestionSign Sign.CentralCyanosis ->
            "Diet"

        QuestionSign Sign.CarotidBruits ->
            "PhysicalExercise"

        QuestionSign Sign.Dysdiado ->
            "Driving"

        QuestionSign Sign.IntentionTremo ->
            "Brudzinski"


list : List Question
list =
    [ QuestionDetails Details.Name
    , QuestionDetails Details.Age
    , QuestionDetails Details.OccupationBrief
    , QuestionDetails Details.OccupationDescription
    , QuestionOpen Open.Opening
    , QuestionOpen Open.Symptoms
    , QuestionOpen Open.Phx
    , QuestionOpen Open.Fhx
    , QuestionPainFeature PainFeature.Where
    , QuestionPainFeature PainFeature.Side
    , QuestionPainFeature PainFeature.Onset
    , QuestionPainFeature PainFeature.Timing
    , QuestionPainFeature PainFeature.Quality
    , QuestionPainFeature PainFeature.Quantity
    , QuestionPainFeature PainFeature.Before
    , QuestionPainFeature PainFeature.Triggers
    , QuestionPainFeature PainFeature.Radiation
    , QuestionSymptomFeature SymptomFeature.Where
    , QuestionSymptomFeature SymptomFeature.Quantity
    , QuestionSymptomFeature SymptomFeature.Alleviating
    , QuestionSymptomFeature SymptomFeature.Aggravating
    , QuestionFeelings Feelings.Beliefs
    , QuestionFeelings Feelings.Impact
    , QuestionFeelings Feelings.Expectations
    , QuestionFeelings Feelings.Concerns
    , QuestionSymptom Symptom.Pain
    , QuestionSymptom Symptom.Nausea
    , QuestionSymptom Symptom.Vomiting
    , QuestionSymptom Symptom.NeckStiff
    , QuestionSymptom Symptom.Diplopia
    , QuestionSymptom Symptom.VisualChange
    , QuestionSymptom Symptom.Photophobia
    , QuestionSymptom Symptom.Rhinorrhoea
    , QuestionSymptom Symptom.Cough
    , QuestionSymptom Symptom.Headache
    , QuestionSymptom Symptom.Lacrimation
    , QuestionSymptom Symptom.RecentlyIll
    , QuestionSymptom Symptom.SickContact
    , QuestionSymptom Symptom.Fever
    , QuestionSymptom Symptom.Rash
    , QuestionSymptom Symptom.ChestPain
    , QuestionSymptom Symptom.Dyspnoea
    , QuestionSymptom Symptom.Palpitations
    , QuestionSymptom Symptom.AnkleSwelling
    , QuestionSymptom Symptom.IntermittentClaudication
    , QuestionSymptom Symptom.Orthopnoea
    , QuestionSymptom Symptom.Pnd
    , QuestionSymptom Symptom.Loc
    , QuestionSymptom Symptom.Seizure
    , QuestionSymptom Symptom.Fatigue
    , QuestionSymptom Symptom.Haemoptysis
    , QuestionSymptom Symptom.Sputum
    , QuestionSymptom Symptom.SoreThroat
    , QuestionSymptom Symptom.Diaphoresis
    , QuestionSymptom Symptom.JawClaudication
    , QuestionSymptom Symptom.VIsualChange
    , QuestionRashFeature RashFeature.Where
    , QuestionExamine Examine.Rash
    , QuestionExamine Examine.Hands
    , QuestionExamine Examine.General
    , QuestionExamine Examine.Vitals
    , QuestionExamine Examine.Weight
    , QuestionExamine Examine.Surroundings
    , QuestionExamine Examine.Nails
    , QuestionExamine Examine.Arms
    , QuestionExamine Examine.EyeMovements
    , QuestionExamine Examine.VisualFields
    , QuestionExamine Examine.HandMovements
    , QuestionExamine Examine.Fundus
    , QuestionExamine Examine.Snellen
    , QuestionExamine Examine.Pupils
    , QuestionExamine Examine.FacialExpression
    , QuestionExamine Examine.Mastication
    , QuestionExamine Examine.Tongue
    , QuestionExamine Examine.OralMucosa
    , QuestionExamine Examine.HeartAuscultate
    , QuestionExamine Examine.LungsAuscultate
    , QuestionExamine Examine.LungsPercussion
    , QuestionExamine Examine.Chest
    , QuestionExamine Examine.Neck
    , QuestionExamine Examine.PowerArms
    , QuestionExamine Examine.PowerLegs
    , QuestionExamine Examine.SensationArms
    , QuestionExamine Examine.SensationLegs
    , QuestionExamine Examine.MentalState
    , QuestionLocFeature LocFeature.When
    , QuestionSeizureFeature SeizureFeature.Before
    , QuestionSputumFeature SputumFeature.Volume
    , QuestionSputumFeature SputumFeature.Colour
    , QuestionPhx Phx.Hypertension
    , QuestionPhx Phx.Diabetes
    , QuestionPhx Phx.Surgery
    , QuestionPhx Phx.Immunisation
    , QuestionDrugs Drugs.Regular
    , QuestionDrugs Drugs.Otc
    , QuestionDrugs Drugs.Recreational
    , QuestionDrugs Drugs.Allergies
    , QuestionAlcohol Alcohol.YesNo
    , QuestionAlcohol Alcohol.Quantity
    , QuestionSmoke Smoke.YesNo
    , QuestionSmoke Smoke.Duration
    , QuestionSmoke Smoke.History
    , QuestionSmoke Smoke.Quantity
    , QuestionFhx Fhx.ParentHealth
    , QuestionFhx Fhx.Children
    , QuestionFhx Fhx.ChildrenHealth
    , QuestionFhx Fhx.Siblings
    , QuestionFhx Fhx.SiblingsHealth
    , QuestionShx Shx.LivingPlace
    , QuestionShx Shx.LivingPeople
    , QuestionShx Shx.Mood
    , QuestionShx Shx.Diet
    , QuestionShx Shx.PhysicalExercise
    , QuestionShx Shx.Driving
    , QuestionSign Sign.Brudzinski
    , QuestionSign Sign.Papilloedema
    , QuestionSign Sign.Kernig
    , QuestionSign Sign.PeripheralCyanosis
    , QuestionSign Sign.CentralCyanosis
    , QuestionSign Sign.CarotidBruits
    , QuestionSign Sign.Dysdiado
    , QuestionSign Sign.IntentionTremo
    ]


optionList : (Question -> msg) -> List (Option.Data Question msg)
optionList msg =
    [ { value = QuestionDetails Details.Name, string = "What is your name?", onClick = msg, tags = "name" }
    , { value = QuestionDetails Details.Age, string = "How old are you?", onClick = msg, tags = "nan" }
    , { value = QuestionDetails Details.Age, string = "When were you born?", onClick = msg, tags = "date of birth dob" }
    , { value = QuestionDetails Details.OccupationBrief, string = "Do you work?", onClick = msg, tags = "employed job" }
    , { value = QuestionDetails Details.OccupationDescription, string = "What do you work as?", onClick = msg, tags = "job" }
    , { value = QuestionOpen Open.Opening, string = "What's brought you in today?", onClick = msg, tags = "nan" }
    , { value = QuestionOpen Open.Opening, string = "Why have you come to see us today?", onClick = msg, tags = "nan" }
    , { value = QuestionOpen Open.Opening, string = "How can I help you today?", onClick = msg, tags = "nan" }
    , { value = QuestionPainFeature PainFeature.Where, string = "Where is the pain?", onClick = msg, tags = "location site" }
    , { value = QuestionPainFeature PainFeature.Side, string = "Which side do you feel the pain on?", onClick = msg, tags = "unilateral bilateral " }
    , { value = QuestionPainFeature PainFeature.Onset, string = "When did the pain start?", onClick = msg, tags = "onset time how long" }
    , { value = QuestionPainFeature PainFeature.Timing, string = "Has the pain gotten better or worse since it started?", onClick = msg, tags = "improve progress timing course" }
    , { value = QuestionPainFeature PainFeature.Quality, string = "How would you describe the pain?", onClick = msg, tags = "quality character " }
    , { value = QuestionPainFeature PainFeature.Quantity, string = "How would you rate the pain out of 10?", onClick = msg, tags = "severity severe quantity" }
    , { value = QuestionPainFeature PainFeature.Before, string = "Have you had this pain before?", onClick = msg, tags = "nan" }
    , { value = QuestionPainFeature PainFeature.Triggers, string = "What triggers the pain?", onClick = msg, tags = "nan" }
    , { value = QuestionPainFeature PainFeature.Radiation, string = "Does the pain radiate or go anywhere else?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptomFeature SymptomFeature.Where, string = "When did your symptoms start?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptomFeature SymptomFeature.Quantity, string = "How severe are your symptoms?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptomFeature SymptomFeature.Alleviating, string = "Does anything make it better?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptomFeature SymptomFeature.Aggravating, string = "Does anything make it worse?", onClick = msg, tags = "nan" }
    , { value = QuestionOpen Open.Symptoms, string = "What other symptoms do you have?", onClick = msg, tags = "nan" }
    , { value = QuestionFeelings Feelings.Beliefs, string = "What do you believe is causing your symptoms?", onClick = msg, tags = "nan" }
    , { value = QuestionFeelings Feelings.Impact, string = "How are your symptoms impacting you?", onClick = msg, tags = "nan" }
    , { value = QuestionFeelings Feelings.Expectations, string = "What are you expectations from our consultation today?", onClick = msg, tags = "nan" }
    , { value = QuestionFeelings Feelings.Concerns, string = "What are you most concerned about?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.Pain, string = "Do you have any pain?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.Nausea, string = "Do you feel nauseous?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.Vomiting, string = "Have you vomited?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.NeckStiff, string = "Do you have a stiff neck?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.Diplopia, string = "Do you have double vision?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.VisualChange, string = "Are there any changes to your vision?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.Photophobia, string = "Do lights make your pain worse?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.Rhinorrhoea, string = "Do you have a runny nose?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.Cough, string = "Do you have a cough?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.Headache, string = "Do you have a headache?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.Lacrimation, string = "Are your eyes teary?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.RecentlyIll, string = "Have you been sick recently?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.SickContact, string = "Has anyone around you been sick recently?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.SickContact, string = "Have you been in contact with anyone sick?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.Fever, string = "Do you have a fever?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.Rash, string = "Do you have a rash?", onClick = msg, tags = "nan" }
    , { value = QuestionRashFeature RashFeature.Where, string = "Where is the rash?", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.Rash, string = "Examine the rash.", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.ChestPain, string = "Do you have any chest pain?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.Dyspnoea, string = "Do you feel short of breath?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.Palpitations, string = "Do you feel like your heartbeat is abnormal?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.AnkleSwelling, string = "Have your ankles been swollen?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.IntermittentClaudication, string = "Do you have pain in your legs when you walk?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.Orthopnoea, string = "Do you feel short of breath when you lie down?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.Pnd, string = "Do you wake up at night gasping for breath?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.Loc, string = "Have you fainted?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.Loc, string = "Have you lost consciousness?", onClick = msg, tags = "nan" }
    , { value = QuestionLocFeature LocFeature.When, string = "When did you lose consciousness?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.Seizure, string = "Did you have a seizure?", onClick = msg, tags = "nan" }
    , { value = QuestionSeizureFeature SeizureFeature.Before, string = "Have you had a seizure before?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.Fatigue, string = "Do you feel fatigued?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.Fatigue, string = "Do you feel tired?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.Haemoptysis, string = "Have you coughed up any blood?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.Sputum, string = "Have you coughed up any sputum?", onClick = msg, tags = "nan" }
    , { value = QuestionSputumFeature SputumFeature.Volume, string = "How much sputum comes up?", onClick = msg, tags = "nan" }
    , { value = QuestionSputumFeature SputumFeature.Colour, string = "What colour is the sputum?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.SoreThroat, string = "Do you have a sore throat?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.Diaphoresis, string = "Do you feel sweaty?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.JawClaudication, string = "Do you feel any pain when you chew?", onClick = msg, tags = "nan" }
    , { value = QuestionSymptom Symptom.VIsualChange, string = "How is your vision?", onClick = msg, tags = "nan" }
    , { value = QuestionOpen Open.Phx, string = "Do you have any medical conditions?", onClick = msg, tags = "nan" }
    , { value = QuestionPhx Phx.Hypertension, string = "Do you have high blood pressure?", onClick = msg, tags = "nan" }
    , { value = QuestionPhx Phx.Diabetes, string = "Do you have diabetes?", onClick = msg, tags = "nan" }
    , { value = QuestionPhx Phx.Surgery, string = "Have you had any surgeries in the past?", onClick = msg, tags = "nan" }
    , { value = QuestionPhx Phx.Immunisation, string = "Are your immunisations up to date?", onClick = msg, tags = "nan" }
    , { value = QuestionDrugs Drugs.Regular, string = "Are you taking any regular medications?", onClick = msg, tags = "nan" }
    , { value = QuestionDrugs Drugs.Otc, string = "Are you taking any over the counter medications?", onClick = msg, tags = "nan" }
    , { value = QuestionDrugs Drugs.Recreational, string = "Do you use any recreational drugs?", onClick = msg, tags = "nan" }
    , { value = QuestionDrugs Drugs.Allergies, string = "Do you have any allergies, and what reactions do you get?", onClick = msg, tags = "nan" }
    , { value = QuestionAlcohol Alcohol.YesNo, string = "Do you drink alcohol?", onClick = msg, tags = "nan" }
    , { value = QuestionAlcohol Alcohol.Quantity, string = "How much alcohol do you drink?", onClick = msg, tags = "nan" }
    , { value = QuestionSmoke Smoke.YesNo, string = "Do you smoke?", onClick = msg, tags = "nan" }
    , { value = QuestionSmoke Smoke.Duration, string = "How long have you smoked for?", onClick = msg, tags = "nan" }
    , { value = QuestionSmoke Smoke.History, string = "Have you ever smoked?", onClick = msg, tags = "nan" }
    , { value = QuestionSmoke Smoke.Quantity, string = "How many cigarettes a day do you or did you smoke?", onClick = msg, tags = "nan" }
    , { value = QuestionOpen Open.Fhx, string = "Do any conditions run through the family?", onClick = msg, tags = "nan" }
    , { value = QuestionFhx Fhx.ParentHealth, string = "How are your parents' health?", onClick = msg, tags = "nan" }
    , { value = QuestionFhx Fhx.Children, string = "Do you have any children?", onClick = msg, tags = "nan" }
    , { value = QuestionFhx Fhx.ChildrenHealth, string = "How are your children's health?", onClick = msg, tags = "nan" }
    , { value = QuestionFhx Fhx.Siblings, string = "Do you have any siblings?", onClick = msg, tags = "nan" }
    , { value = QuestionFhx Fhx.SiblingsHealth, string = "How are your siblings' health?", onClick = msg, tags = "nan" }
    , { value = QuestionShx Shx.LivingPlace, string = "Where do you live at the moment?", onClick = msg, tags = "nan" }
    , { value = QuestionShx Shx.LivingPeople, string = "Who do you live with at the moment?", onClick = msg, tags = "nan" }
    , { value = QuestionShx Shx.LivingPeople, string = "Do you live by yourself?", onClick = msg, tags = "nan" }
    , { value = QuestionShx Shx.Mood, string = "How is your mood?", onClick = msg, tags = "nan" }
    , { value = QuestionShx Shx.Diet, string = "What are do you usually eat day to day?", onClick = msg, tags = "nan" }
    , { value = QuestionShx Shx.PhysicalExercise, string = "Do you do physical exercise?", onClick = msg, tags = "nan" }
    , { value = QuestionShx Shx.Driving, string = "Do you drive?", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.Hands, string = "Examine the hands. ", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.General, string = "Examine with general inspection.", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.Vitals, string = "Examine the vital signs.", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.Weight, string = "Examine weight.", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.Surroundings, string = "Examine the surroundings.", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.Nails, string = "Examine the nails.", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.Arms, string = "Examine the arms.", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.EyeMovements, string = "Examine the eye movements.", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.VisualFields, string = "Examine the visual fields with a confrontation test.", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.HandMovements, string = "Examine hand movements.", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.Fundus, string = "Examine the fundus with an ophthalmoscope.", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.Snellen, string = "Examine visual acuity with a Snellen chart.", onClick = msg, tags = "nan" }
    , { value = QuestionSign Sign.Brudzinski, string = "Check for Brudzinski's sign.", onClick = msg, tags = "nan" }
    , { value = QuestionSign Sign.Papilloedema, string = "Check for papilloedema.", onClick = msg, tags = "nan" }
    , { value = QuestionSign Sign.Kernig, string = "Check for Kernig's sign.", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.Pupils, string = "Examine the pupil reflexes.", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.FacialExpression, string = "Examine the muscles of facial expression.", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.Mastication, string = "Examine the muscles of mastication.", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.Tongue, string = "Examine the tongue.", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.OralMucosa, string = "Examine the oral mucosa.", onClick = msg, tags = "nan" }
    , { value = QuestionSign Sign.PeripheralCyanosis, string = "Check for peripheral cyanosis.", onClick = msg, tags = "nan" }
    , { value = QuestionSign Sign.CentralCyanosis, string = "Check for central cyanosis.", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.HeartAuscultate, string = "Examine the heart by auscultation.", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.LungsAuscultate, string = "Examine the lungs by auscultation.", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.LungsPercussion, string = "Examine the lungs by percussion.", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.Chest, string = "Examine the chest.", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.Neck, string = "Examine the neck.", onClick = msg, tags = "nan" }
    , { value = QuestionSign Sign.CarotidBruits, string = "Check for carotid bruits.", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.PowerArms, string = "Examine the power of the arms.", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.PowerLegs, string = "Examine the power of the legs.", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.SensationArms, string = "Examine the sensation over the arms.", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.SensationLegs, string = "Examine the sensation over the legs.", onClick = msg, tags = "nan" }
    , { value = QuestionSign Sign.Dysdiado, string = "Check for dysdiadochokinesia.", onClick = msg, tags = "nan" }
    , { value = QuestionSign Sign.IntentionTremo, string = "Check for intention tremor.", onClick = msg, tags = "nan" }
    , { value = QuestionExamine Examine.MentalState, string = "Examine the mental state of the patient.", onClick = msg, tags = "nan" }
    ]
