module Questions.Question exposing (..)

import Option
import Array exposing (Array)

import Questions.Details as Details exposing (..)
import Questions.Open as Open exposing (..)
import Questions.PainFeature as PainFeature exposing (..)
import Questions.SymptomFeature as SymptomFeature exposing (..)
import Questions.Feelings as Feelings exposing (..)
import Questions.Symptom as Symptom exposing (..)
import Questions.RashFeature as RashFeature exposing (..)
import Questions.Examine as Examine exposing (..)
import Questions.DyspnoeaFeature as DyspnoeaFeature exposing (..)
import Questions.LocFeature as LocFeature exposing (..)
import Questions.SeizureFeature as SeizureFeature exposing (..)
import Questions.SputumFeature as SputumFeature exposing (..)
import Questions.Phx as Phx exposing (..)
import Questions.Drugs as Drugs exposing (..)
import Questions.Alcohol as Alcohol exposing (..)
import Questions.Smoke as Smoke exposing (..)
import Questions.Fhx as Fhx exposing (..)
import Questions.Shx as Shx exposing (..)
import Questions.Sign as Sign exposing (..)

type Question = QuestionDetails Details
    | QuestionOpen Open
    | QuestionPainFeature PainFeature
    | QuestionSymptomFeature SymptomFeature
    | QuestionFeelings Feelings
    | QuestionSymptom Symptom
    | QuestionRashFeature RashFeature
    | QuestionExamine Examine
    | QuestionDyspnoeaFeature DyspnoeaFeature
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
        0 -> QuestionDetails Details.Name
        1 -> QuestionDetails Details.Age
        2 -> QuestionDetails Details.Dob
        3 -> QuestionDetails Details.OccupationBrief
        4 -> QuestionDetails Details.OccupationDescription
        5 -> QuestionOpen Open.Greeting
        6 -> QuestionOpen Open.Opening
        7 -> QuestionOpen Open.Symptoms
        8 -> QuestionOpen Open.Phx
        9 -> QuestionOpen Open.Fhx
        10 -> QuestionPainFeature PainFeature.Where
        11 -> QuestionPainFeature PainFeature.Side
        12 -> QuestionPainFeature PainFeature.Activity
        13 -> QuestionPainFeature PainFeature.Onset
        14 -> QuestionPainFeature PainFeature.Timing
        15 -> QuestionPainFeature PainFeature.Quality
        16 -> QuestionPainFeature PainFeature.Quantity
        17 -> QuestionPainFeature PainFeature.Before
        18 -> QuestionPainFeature PainFeature.Triggers
        19 -> QuestionPainFeature PainFeature.Radiation
        20 -> QuestionSymptomFeature SymptomFeature.When
        21 -> QuestionSymptomFeature SymptomFeature.Quantity
        22 -> QuestionSymptomFeature SymptomFeature.Alleviating
        23 -> QuestionSymptomFeature SymptomFeature.Aggravating
        24 -> QuestionFeelings Feelings.Beliefs
        25 -> QuestionFeelings Feelings.Impact
        26 -> QuestionFeelings Feelings.Expectations
        27 -> QuestionFeelings Feelings.Concerns
        28 -> QuestionSymptom Symptom.Pain
        29 -> QuestionSymptom Symptom.Nausea
        30 -> QuestionSymptom Symptom.Vomiting
        31 -> QuestionSymptom Symptom.NeckStiff
        32 -> QuestionSymptom Symptom.Diplopia
        33 -> QuestionSymptom Symptom.VisualChange
        34 -> QuestionSymptom Symptom.Photophobia
        35 -> QuestionSymptom Symptom.Rhinorrhoea
        36 -> QuestionSymptom Symptom.Cough
        37 -> QuestionSymptom Symptom.Headache
        38 -> QuestionSymptom Symptom.Lacrimation
        39 -> QuestionSymptom Symptom.RecentlyIll
        40 -> QuestionSymptom Symptom.SickContact
        41 -> QuestionSymptom Symptom.Fever
        42 -> QuestionSymptom Symptom.Rash
        43 -> QuestionSymptom Symptom.ChestPain
        44 -> QuestionSymptom Symptom.Dyspnoea
        45 -> QuestionSymptom Symptom.Palpitations
        46 -> QuestionSymptom Symptom.AnkleSwelling
        47 -> QuestionSymptom Symptom.IntermittentClaudication
        48 -> QuestionSymptom Symptom.Orthopnoea
        49 -> QuestionSymptom Symptom.Pnd
        50 -> QuestionSymptom Symptom.Loc
        51 -> QuestionSymptom Symptom.Seizure
        52 -> QuestionSymptom Symptom.Fatigue
        53 -> QuestionSymptom Symptom.Haemoptysis
        54 -> QuestionSymptom Symptom.Sputum
        55 -> QuestionSymptom Symptom.SoreThroat
        56 -> QuestionSymptom Symptom.Diaphoresis
        57 -> QuestionSymptom Symptom.JawClaudication
        58 -> QuestionSymptom Symptom.VIsualChange
        59 -> QuestionRashFeature RashFeature.Where
        60 -> QuestionExamine Examine.Rash
        61 -> QuestionExamine Examine.Hands
        62 -> QuestionExamine Examine.General
        63 -> QuestionExamine Examine.Vitals
        64 -> QuestionExamine Examine.Oxygen
        65 -> QuestionExamine Examine.GCS
        66 -> QuestionExamine Examine.Weight
        67 -> QuestionExamine Examine.Height
        68 -> QuestionExamine Examine.Surroundings
        69 -> QuestionExamine Examine.Nails
        70 -> QuestionExamine Examine.Arms
        71 -> QuestionExamine Examine.EyeMovements
        72 -> QuestionExamine Examine.VisualFields
        73 -> QuestionExamine Examine.HandMovements
        74 -> QuestionExamine Examine.Fundus
        75 -> QuestionExamine Examine.Snellen
        76 -> QuestionExamine Examine.ECG
        77 -> QuestionExamine Examine.Pupils
        78 -> QuestionExamine Examine.FacialExpression
        79 -> QuestionExamine Examine.Mastication
        80 -> QuestionExamine Examine.Tongue
        81 -> QuestionExamine Examine.OralMucosa
        82 -> QuestionExamine Examine.HeartAuscultate
        83 -> QuestionExamine Examine.LungsAuscultate
        84 -> QuestionExamine Examine.LungsPercussion
        85 -> QuestionExamine Examine.Chest
        86 -> QuestionExamine Examine.Neck
        87 -> QuestionExamine Examine.PowerArms
        88 -> QuestionExamine Examine.PowerLegs
        89 -> QuestionExamine Examine.SensationArms
        90 -> QuestionExamine Examine.SensationLegs
        91 -> QuestionExamine Examine.MentalState
        92 -> QuestionDyspnoeaFeature DyspnoeaFeature.Precipitants
        93 -> QuestionLocFeature LocFeature.When
        94 -> QuestionSeizureFeature SeizureFeature.Before
        95 -> QuestionSputumFeature SputumFeature.Volume
        96 -> QuestionSputumFeature SputumFeature.Colour
        97 -> QuestionPhx Phx.Hypertension
        98 -> QuestionPhx Phx.Diabetes
        99 -> QuestionPhx Phx.DiabetesType
        100 -> QuestionPhx Phx.Surgery
        101 -> QuestionPhx Phx.Immunisation
        102 -> QuestionDrugs Drugs.Regular
        103 -> QuestionDrugs Drugs.Otc
        104 -> QuestionDrugs Drugs.Recreational
        105 -> QuestionDrugs Drugs.Allergies
        106 -> QuestionAlcohol Alcohol.YesNo
        107 -> QuestionAlcohol Alcohol.Quantity
        108 -> QuestionSmoke Smoke.YesNo
        109 -> QuestionSmoke Smoke.Duration
        110 -> QuestionSmoke Smoke.History
        111 -> QuestionSmoke Smoke.Quantity
        112 -> QuestionFhx Fhx.ParentHealth
        113 -> QuestionFhx Fhx.Children
        114 -> QuestionFhx Fhx.ChildrenHealth
        115 -> QuestionFhx Fhx.Siblings
        116 -> QuestionFhx Fhx.SiblingsHealth
        117 -> QuestionShx Shx.LivingPlace
        118 -> QuestionShx Shx.LivingPeople
        119 -> QuestionShx Shx.Mood
        120 -> QuestionShx Shx.Diet
        121 -> QuestionShx Shx.PhysicalExercise
        122 -> QuestionShx Shx.Driving
        123 -> QuestionShx Shx.Hobbies
        124 -> QuestionShx Shx.GP
        125 -> QuestionSign Sign.Brudzinski
        126 -> QuestionSign Sign.Papilloedema
        127 -> QuestionSign Sign.Kernig
        128 -> QuestionSign Sign.PeripheralCyanosis
        129 -> QuestionSign Sign.CentralCyanosis
        130 -> QuestionSign Sign.CarotidBruits
        131 -> QuestionSign Sign.Dysdiado
        132 -> QuestionSign Sign.IntentionTremo
        _ -> QuestionDetails Details.Name

toInt : Question -> Int
toInt enum = 
    case enum of 
        QuestionDetails Details.Name -> 0
        QuestionDetails Details.Age -> 1
        QuestionDetails Details.Dob -> 2
        QuestionDetails Details.OccupationBrief -> 3
        QuestionDetails Details.OccupationDescription -> 4
        QuestionOpen Open.Greeting -> 5
        QuestionOpen Open.Opening -> 6
        QuestionOpen Open.Symptoms -> 7
        QuestionOpen Open.Phx -> 8
        QuestionOpen Open.Fhx -> 9
        QuestionPainFeature PainFeature.Where -> 10
        QuestionPainFeature PainFeature.Side -> 11
        QuestionPainFeature PainFeature.Activity -> 12
        QuestionPainFeature PainFeature.Onset -> 13
        QuestionPainFeature PainFeature.Timing -> 14
        QuestionPainFeature PainFeature.Quality -> 15
        QuestionPainFeature PainFeature.Quantity -> 16
        QuestionPainFeature PainFeature.Before -> 17
        QuestionPainFeature PainFeature.Triggers -> 18
        QuestionPainFeature PainFeature.Radiation -> 19
        QuestionSymptomFeature SymptomFeature.When -> 20
        QuestionSymptomFeature SymptomFeature.Quantity -> 21
        QuestionSymptomFeature SymptomFeature.Alleviating -> 22
        QuestionSymptomFeature SymptomFeature.Aggravating -> 23
        QuestionFeelings Feelings.Beliefs -> 24
        QuestionFeelings Feelings.Impact -> 25
        QuestionFeelings Feelings.Expectations -> 26
        QuestionFeelings Feelings.Concerns -> 27
        QuestionSymptom Symptom.Pain -> 28
        QuestionSymptom Symptom.Nausea -> 29
        QuestionSymptom Symptom.Vomiting -> 30
        QuestionSymptom Symptom.NeckStiff -> 31
        QuestionSymptom Symptom.Diplopia -> 32
        QuestionSymptom Symptom.VisualChange -> 33
        QuestionSymptom Symptom.Photophobia -> 34
        QuestionSymptom Symptom.Rhinorrhoea -> 35
        QuestionSymptom Symptom.Cough -> 36
        QuestionSymptom Symptom.Headache -> 37
        QuestionSymptom Symptom.Lacrimation -> 38
        QuestionSymptom Symptom.RecentlyIll -> 39
        QuestionSymptom Symptom.SickContact -> 40
        QuestionSymptom Symptom.Fever -> 41
        QuestionSymptom Symptom.Rash -> 42
        QuestionSymptom Symptom.ChestPain -> 43
        QuestionSymptom Symptom.Dyspnoea -> 44
        QuestionSymptom Symptom.Palpitations -> 45
        QuestionSymptom Symptom.AnkleSwelling -> 46
        QuestionSymptom Symptom.IntermittentClaudication -> 47
        QuestionSymptom Symptom.Orthopnoea -> 48
        QuestionSymptom Symptom.Pnd -> 49
        QuestionSymptom Symptom.Loc -> 50
        QuestionSymptom Symptom.Seizure -> 51
        QuestionSymptom Symptom.Fatigue -> 52
        QuestionSymptom Symptom.Haemoptysis -> 53
        QuestionSymptom Symptom.Sputum -> 54
        QuestionSymptom Symptom.SoreThroat -> 55
        QuestionSymptom Symptom.Diaphoresis -> 56
        QuestionSymptom Symptom.JawClaudication -> 57
        QuestionSymptom Symptom.VIsualChange -> 58
        QuestionRashFeature RashFeature.Where -> 59
        QuestionExamine Examine.Rash -> 60
        QuestionExamine Examine.Hands -> 61
        QuestionExamine Examine.General -> 62
        QuestionExamine Examine.Vitals -> 63
        QuestionExamine Examine.Oxygen -> 64
        QuestionExamine Examine.GCS -> 65
        QuestionExamine Examine.Weight -> 66
        QuestionExamine Examine.Height -> 67
        QuestionExamine Examine.Surroundings -> 68
        QuestionExamine Examine.Nails -> 69
        QuestionExamine Examine.Arms -> 70
        QuestionExamine Examine.EyeMovements -> 71
        QuestionExamine Examine.VisualFields -> 72
        QuestionExamine Examine.HandMovements -> 73
        QuestionExamine Examine.Fundus -> 74
        QuestionExamine Examine.Snellen -> 75
        QuestionExamine Examine.ECG -> 76
        QuestionExamine Examine.Pupils -> 77
        QuestionExamine Examine.FacialExpression -> 78
        QuestionExamine Examine.Mastication -> 79
        QuestionExamine Examine.Tongue -> 80
        QuestionExamine Examine.OralMucosa -> 81
        QuestionExamine Examine.HeartAuscultate -> 82
        QuestionExamine Examine.LungsAuscultate -> 83
        QuestionExamine Examine.LungsPercussion -> 84
        QuestionExamine Examine.Chest -> 85
        QuestionExamine Examine.Neck -> 86
        QuestionExamine Examine.PowerArms -> 87
        QuestionExamine Examine.PowerLegs -> 88
        QuestionExamine Examine.SensationArms -> 89
        QuestionExamine Examine.SensationLegs -> 90
        QuestionExamine Examine.MentalState -> 91
        QuestionDyspnoeaFeature DyspnoeaFeature.Precipitants -> 92
        QuestionLocFeature LocFeature.When -> 93
        QuestionSeizureFeature SeizureFeature.Before -> 94
        QuestionSputumFeature SputumFeature.Volume -> 95
        QuestionSputumFeature SputumFeature.Colour -> 96
        QuestionPhx Phx.Hypertension -> 97
        QuestionPhx Phx.Diabetes -> 98
        QuestionPhx Phx.DiabetesType -> 99
        QuestionPhx Phx.Surgery -> 100
        QuestionPhx Phx.Immunisation -> 101
        QuestionDrugs Drugs.Regular -> 102
        QuestionDrugs Drugs.Otc -> 103
        QuestionDrugs Drugs.Recreational -> 104
        QuestionDrugs Drugs.Allergies -> 105
        QuestionAlcohol Alcohol.YesNo -> 106
        QuestionAlcohol Alcohol.Quantity -> 107
        QuestionSmoke Smoke.YesNo -> 108
        QuestionSmoke Smoke.Duration -> 109
        QuestionSmoke Smoke.History -> 110
        QuestionSmoke Smoke.Quantity -> 111
        QuestionFhx Fhx.ParentHealth -> 112
        QuestionFhx Fhx.Children -> 113
        QuestionFhx Fhx.ChildrenHealth -> 114
        QuestionFhx Fhx.Siblings -> 115
        QuestionFhx Fhx.SiblingsHealth -> 116
        QuestionShx Shx.LivingPlace -> 117
        QuestionShx Shx.LivingPeople -> 118
        QuestionShx Shx.Mood -> 119
        QuestionShx Shx.Diet -> 120
        QuestionShx Shx.PhysicalExercise -> 121
        QuestionShx Shx.Driving -> 122
        QuestionShx Shx.Hobbies -> 123
        QuestionShx Shx.GP -> 124
        QuestionSign Sign.Brudzinski -> 125
        QuestionSign Sign.Papilloedema -> 126
        QuestionSign Sign.Kernig -> 127
        QuestionSign Sign.PeripheralCyanosis -> 128
        QuestionSign Sign.CentralCyanosis -> 129
        QuestionSign Sign.CarotidBruits -> 130
        QuestionSign Sign.Dysdiado -> 131
        QuestionSign Sign.IntentionTremo -> 132

toString : Question -> String
toString enum = 
    case enum of
        QuestionDetails Details.Name -> "Name"
        QuestionDetails Details.Age -> "Age"
        QuestionDetails Details.Dob -> "Dob"
        QuestionDetails Details.OccupationBrief -> "OccupationBrief"
        QuestionDetails Details.OccupationDescription -> "OccupationDescription"
        QuestionOpen Open.Greeting -> "Greeting"
        QuestionOpen Open.Opening -> "Opening"
        QuestionOpen Open.Symptoms -> "Opening"
        QuestionOpen Open.Phx -> "Opening"
        QuestionOpen Open.Fhx -> "Symptoms"
        QuestionPainFeature PainFeature.Where -> "Phx"
        QuestionPainFeature PainFeature.Side -> "Fhx"
        QuestionPainFeature PainFeature.Activity -> "Where"
        QuestionPainFeature PainFeature.Onset -> "Side"
        QuestionPainFeature PainFeature.Timing -> "Activity"
        QuestionPainFeature PainFeature.Quality -> "Onset"
        QuestionPainFeature PainFeature.Quantity -> "Timing"
        QuestionPainFeature PainFeature.Before -> "Quality"
        QuestionPainFeature PainFeature.Triggers -> "Quantity"
        QuestionPainFeature PainFeature.Radiation -> "Before"
        QuestionSymptomFeature SymptomFeature.When -> "Triggers"
        QuestionSymptomFeature SymptomFeature.Quantity -> "Radiation"
        QuestionSymptomFeature SymptomFeature.Alleviating -> "When"
        QuestionSymptomFeature SymptomFeature.Aggravating -> "Quantity"
        QuestionFeelings Feelings.Beliefs -> "Alleviating"
        QuestionFeelings Feelings.Impact -> "Aggravating"
        QuestionFeelings Feelings.Expectations -> "Beliefs"
        QuestionFeelings Feelings.Concerns -> "Impact"
        QuestionSymptom Symptom.Pain -> "Expectations"
        QuestionSymptom Symptom.Nausea -> "Concerns"
        QuestionSymptom Symptom.Vomiting -> "Pain"
        QuestionSymptom Symptom.NeckStiff -> "Nausea"
        QuestionSymptom Symptom.Diplopia -> "Vomiting"
        QuestionSymptom Symptom.VisualChange -> "NeckStiff"
        QuestionSymptom Symptom.Photophobia -> "Diplopia"
        QuestionSymptom Symptom.Rhinorrhoea -> "VisualChange"
        QuestionSymptom Symptom.Cough -> "Photophobia"
        QuestionSymptom Symptom.Headache -> "Rhinorrhoea"
        QuestionSymptom Symptom.Lacrimation -> "Cough"
        QuestionSymptom Symptom.RecentlyIll -> "Headache"
        QuestionSymptom Symptom.SickContact -> "Lacrimation"
        QuestionSymptom Symptom.Fever -> "RecentlyIll"
        QuestionSymptom Symptom.Rash -> "SickContact"
        QuestionSymptom Symptom.ChestPain -> "SickContact"
        QuestionSymptom Symptom.Dyspnoea -> "Fever"
        QuestionSymptom Symptom.Palpitations -> "Rash"
        QuestionSymptom Symptom.AnkleSwelling -> "ChestPain"
        QuestionSymptom Symptom.IntermittentClaudication -> "Dyspnoea"
        QuestionSymptom Symptom.Orthopnoea -> "Palpitations"
        QuestionSymptom Symptom.Pnd -> "AnkleSwelling"
        QuestionSymptom Symptom.Loc -> "IntermittentClaudication"
        QuestionSymptom Symptom.Seizure -> "Orthopnoea"
        QuestionSymptom Symptom.Fatigue -> "Pnd"
        QuestionSymptom Symptom.Haemoptysis -> "Loc"
        QuestionSymptom Symptom.Sputum -> "Loc"
        QuestionSymptom Symptom.SoreThroat -> "Seizure"
        QuestionSymptom Symptom.Diaphoresis -> "Fatigue"
        QuestionSymptom Symptom.JawClaudication -> "Fatigue"
        QuestionSymptom Symptom.VIsualChange -> "Haemoptysis"
        QuestionRashFeature RashFeature.Where -> "Sputum"
        QuestionExamine Examine.Rash -> "SoreThroat"
        QuestionExamine Examine.Hands -> "Diaphoresis"
        QuestionExamine Examine.General -> "JawClaudication"
        QuestionExamine Examine.Vitals -> "VIsualChange"
        QuestionExamine Examine.Oxygen -> "Where"
        QuestionExamine Examine.GCS -> "Rash"
        QuestionExamine Examine.Weight -> "Hands"
        QuestionExamine Examine.Height -> "General"
        QuestionExamine Examine.Surroundings -> "Vitals"
        QuestionExamine Examine.Nails -> "Oxygen"
        QuestionExamine Examine.Arms -> "GCS"
        QuestionExamine Examine.EyeMovements -> "Weight"
        QuestionExamine Examine.VisualFields -> "Height"
        QuestionExamine Examine.HandMovements -> "Surroundings"
        QuestionExamine Examine.Fundus -> "Nails"
        QuestionExamine Examine.Snellen -> "Arms"
        QuestionExamine Examine.ECG -> "EyeMovements"
        QuestionExamine Examine.Pupils -> "VisualFields"
        QuestionExamine Examine.FacialExpression -> "HandMovements"
        QuestionExamine Examine.Mastication -> "Fundus"
        QuestionExamine Examine.Tongue -> "Snellen"
        QuestionExamine Examine.OralMucosa -> "ECG"
        QuestionExamine Examine.HeartAuscultate -> "Pupils"
        QuestionExamine Examine.LungsAuscultate -> "FacialExpression"
        QuestionExamine Examine.LungsPercussion -> "Mastication"
        QuestionExamine Examine.Chest -> "Tongue"
        QuestionExamine Examine.Neck -> "OralMucosa"
        QuestionExamine Examine.PowerArms -> "HeartAuscultate"
        QuestionExamine Examine.PowerLegs -> "LungsAuscultate"
        QuestionExamine Examine.SensationArms -> "LungsPercussion"
        QuestionExamine Examine.SensationLegs -> "Chest"
        QuestionExamine Examine.MentalState -> "Neck"
        QuestionDyspnoeaFeature DyspnoeaFeature.Precipitants -> "PowerArms"
        QuestionLocFeature LocFeature.When -> "PowerLegs"
        QuestionSeizureFeature SeizureFeature.Before -> "SensationArms"
        QuestionSputumFeature SputumFeature.Volume -> "SensationLegs"
        QuestionSputumFeature SputumFeature.Colour -> "MentalState"
        QuestionPhx Phx.Hypertension -> "Precipitants"
        QuestionPhx Phx.Diabetes -> "When"
        QuestionPhx Phx.DiabetesType -> "Before"
        QuestionPhx Phx.Surgery -> "Volume"
        QuestionPhx Phx.Immunisation -> "Colour"
        QuestionDrugs Drugs.Regular -> "Hypertension"
        QuestionDrugs Drugs.Otc -> "Diabetes"
        QuestionDrugs Drugs.Recreational -> "DiabetesType"
        QuestionDrugs Drugs.Allergies -> "Surgery"
        QuestionAlcohol Alcohol.YesNo -> "Immunisation"
        QuestionAlcohol Alcohol.Quantity -> "Regular"
        QuestionSmoke Smoke.YesNo -> "Otc"
        QuestionSmoke Smoke.Duration -> "Recreational"
        QuestionSmoke Smoke.History -> "Allergies"
        QuestionSmoke Smoke.Quantity -> "YesNo"
        QuestionFhx Fhx.ParentHealth -> "Quantity"
        QuestionFhx Fhx.Children -> "YesNo"
        QuestionFhx Fhx.ChildrenHealth -> "Duration"
        QuestionFhx Fhx.Siblings -> "History"
        QuestionFhx Fhx.SiblingsHealth -> "Quantity"
        QuestionShx Shx.LivingPlace -> "ParentHealth"
        QuestionShx Shx.LivingPeople -> "Children"
        QuestionShx Shx.Mood -> "ChildrenHealth"
        QuestionShx Shx.Diet -> "Siblings"
        QuestionShx Shx.PhysicalExercise -> "SiblingsHealth"
        QuestionShx Shx.Driving -> "LivingPlace"
        QuestionShx Shx.Hobbies -> "LivingPeople"
        QuestionShx Shx.GP -> "LivingPeople"
        QuestionSign Sign.Brudzinski -> "Mood"
        QuestionSign Sign.Papilloedema -> "Diet"
        QuestionSign Sign.Kernig -> "PhysicalExercise"
        QuestionSign Sign.PeripheralCyanosis -> "Driving"
        QuestionSign Sign.CentralCyanosis -> "Hobbies"
        QuestionSign Sign.CarotidBruits -> "GP"
        QuestionSign Sign.Dysdiado -> "Brudzinski"
        QuestionSign Sign.IntentionTremo -> "Papilloedema"

list : List Question
list = 
    [ QuestionDetails Details.Name
    , QuestionDetails Details.Age
    , QuestionDetails Details.Dob
    , QuestionDetails Details.OccupationBrief
    , QuestionDetails Details.OccupationDescription
    , QuestionOpen Open.Greeting
    , QuestionOpen Open.Opening
    , QuestionOpen Open.Symptoms
    , QuestionOpen Open.Phx
    , QuestionOpen Open.Fhx
    , QuestionPainFeature PainFeature.Where
    , QuestionPainFeature PainFeature.Side
    , QuestionPainFeature PainFeature.Activity
    , QuestionPainFeature PainFeature.Onset
    , QuestionPainFeature PainFeature.Timing
    , QuestionPainFeature PainFeature.Quality
    , QuestionPainFeature PainFeature.Quantity
    , QuestionPainFeature PainFeature.Before
    , QuestionPainFeature PainFeature.Triggers
    , QuestionPainFeature PainFeature.Radiation
    , QuestionSymptomFeature SymptomFeature.When
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
    , QuestionExamine Examine.Oxygen
    , QuestionExamine Examine.GCS
    , QuestionExamine Examine.Weight
    , QuestionExamine Examine.Height
    , QuestionExamine Examine.Surroundings
    , QuestionExamine Examine.Nails
    , QuestionExamine Examine.Arms
    , QuestionExamine Examine.EyeMovements
    , QuestionExamine Examine.VisualFields
    , QuestionExamine Examine.HandMovements
    , QuestionExamine Examine.Fundus
    , QuestionExamine Examine.Snellen
    , QuestionExamine Examine.ECG
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
    , QuestionDyspnoeaFeature DyspnoeaFeature.Precipitants
    , QuestionLocFeature LocFeature.When
    , QuestionSeizureFeature SeizureFeature.Before
    , QuestionSputumFeature SputumFeature.Volume
    , QuestionSputumFeature SputumFeature.Colour
    , QuestionPhx Phx.Hypertension
    , QuestionPhx Phx.Diabetes
    , QuestionPhx Phx.DiabetesType
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
    , QuestionShx Shx.Hobbies
    , QuestionShx Shx.GP
    , QuestionSign Sign.Brudzinski
    , QuestionSign Sign.Papilloedema
    , QuestionSign Sign.Kernig
    , QuestionSign Sign.PeripheralCyanosis
    , QuestionSign Sign.CentralCyanosis
    , QuestionSign Sign.CarotidBruits
    , QuestionSign Sign.Dysdiado
    , QuestionSign Sign.IntentionTremo ]

optionList : (Question -> String -> msg) -> List (Option.Data Question msg)
optionList msg =
    [ { value = QuestionDetails Details.Name, string = "What is your name?", onClick = msg (QuestionDetails Details.Name) "What is your name?", tags = "name" }
    , { value = QuestionDetails Details.Age, string = "How old are you?", onClick = msg (QuestionDetails Details.Age) "How old are you?", tags = "nan" }
    , { value = QuestionDetails Details.Dob, string = "When were you born?", onClick = msg (QuestionDetails Details.Dob) "When were you born?", tags = "date of birth dob" }
    , { value = QuestionDetails Details.OccupationBrief, string = "Do you work?", onClick = msg (QuestionDetails Details.OccupationBrief) "Do you work?", tags = "employed job" }
    , { value = QuestionDetails Details.OccupationDescription, string = "What do you work as?", onClick = msg (QuestionDetails Details.OccupationDescription) "What do you work as?", tags = "job" }
    , { value = QuestionOpen Open.Greeting, string = "Hi. It's nice to meet you.", onClick = msg (QuestionOpen Open.Greeting) "Hi. It's nice to meet you.", tags = "hi hello nice to meet you" }
    , { value = QuestionOpen Open.Opening, string = "What's brought you in today?", onClick = msg (QuestionOpen Open.Opening) "What's brought you in today?", tags = "nan" }
    , { value = QuestionOpen Open.Opening, string = "Why have you come to see us today?", onClick = msg (QuestionOpen Open.Opening) "Why have you come to see us today?", tags = "nan" }
    , { value = QuestionOpen Open.Opening, string = "How can I help you today?", onClick = msg (QuestionOpen Open.Opening) "How can I help you today?", tags = "nan" }
    , { value = QuestionPainFeature PainFeature.Where, string = "Where is the pain?", onClick = msg (QuestionPainFeature PainFeature.Where) "Where is the pain?", tags = "location site" }
    , { value = QuestionPainFeature PainFeature.Side, string = "Which side do you feel the pain on?", onClick = msg (QuestionPainFeature PainFeature.Side) "Which side do you feel the pain on?", tags = "unilateral bilateral " }
    , { value = QuestionPainFeature PainFeature.Activity, string = "What were you doing when the pain started?", onClick = msg (QuestionPainFeature PainFeature.Activity) "What were you doing when the pain started?", tags = "doing at the time" }
    , { value = QuestionPainFeature PainFeature.Onset, string = "When did the pain start?", onClick = msg (QuestionPainFeature PainFeature.Onset) "When did the pain start?", tags = "onset time how long" }
    , { value = QuestionPainFeature PainFeature.Timing, string = "Has the pain gotten better or worse since it started?", onClick = msg (QuestionPainFeature PainFeature.Timing) "Has the pain gotten better or worse since it started?", tags = "improve progress timing course" }
    , { value = QuestionPainFeature PainFeature.Quality, string = "How would you describe the pain?", onClick = msg (QuestionPainFeature PainFeature.Quality) "How would you describe the pain?", tags = "quality character " }
    , { value = QuestionPainFeature PainFeature.Quantity, string = "How would you rate the pain out of 10?", onClick = msg (QuestionPainFeature PainFeature.Quantity) "How would you rate the pain out of 10?", tags = "severity severe quantity" }
    , { value = QuestionPainFeature PainFeature.Before, string = "Have you had this pain before?", onClick = msg (QuestionPainFeature PainFeature.Before) "Have you had this pain before?", tags = "nan" }
    , { value = QuestionPainFeature PainFeature.Triggers, string = "What triggers the pain?", onClick = msg (QuestionPainFeature PainFeature.Triggers) "What triggers the pain?", tags = "nan" }
    , { value = QuestionPainFeature PainFeature.Radiation, string = "Does the pain radiate or go anywhere else?", onClick = msg (QuestionPainFeature PainFeature.Radiation) "Does the pain radiate or go anywhere else?", tags = "nan" }
    , { value = QuestionSymptomFeature SymptomFeature.When, string = "When did your symptoms start?", onClick = msg (QuestionSymptomFeature SymptomFeature.When) "When did your symptoms start?", tags = "nan" }
    , { value = QuestionSymptomFeature SymptomFeature.Quantity, string = "How severe are your symptoms?", onClick = msg (QuestionSymptomFeature SymptomFeature.Quantity) "How severe are your symptoms?", tags = "nan" }
    , { value = QuestionSymptomFeature SymptomFeature.Alleviating, string = "Does anything make it better?", onClick = msg (QuestionSymptomFeature SymptomFeature.Alleviating) "Does anything make it better?", tags = "nan" }
    , { value = QuestionSymptomFeature SymptomFeature.Aggravating, string = "Does anything make it worse?", onClick = msg (QuestionSymptomFeature SymptomFeature.Aggravating) "Does anything make it worse?", tags = "nan" }
    , { value = QuestionOpen Open.Symptoms, string = "What other symptoms do you have?", onClick = msg (QuestionOpen Open.Symptoms) "What other symptoms do you have?", tags = "nan" }
    , { value = QuestionFeelings Feelings.Beliefs, string = "What do you believe is causing your symptoms?", onClick = msg (QuestionFeelings Feelings.Beliefs) "What do you believe is causing your symptoms?", tags = "nan" }
    , { value = QuestionFeelings Feelings.Impact, string = "How are your symptoms impacting you?", onClick = msg (QuestionFeelings Feelings.Impact) "How are your symptoms impacting you?", tags = "nan" }
    , { value = QuestionFeelings Feelings.Expectations, string = "What are you expectations from our consultation today?", onClick = msg (QuestionFeelings Feelings.Expectations) "What are you expectations from our consultation today?", tags = "nan" }
    , { value = QuestionFeelings Feelings.Concerns, string = "What are you most concerned about?", onClick = msg (QuestionFeelings Feelings.Concerns) "What are you most concerned about?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Pain, string = "Do you have any pain?", onClick = msg (QuestionSymptom Symptom.Pain) "Do you have any pain?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Nausea, string = "Do you feel nauseous?", onClick = msg (QuestionSymptom Symptom.Nausea) "Do you feel nauseous?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Vomiting, string = "Have you vomited?", onClick = msg (QuestionSymptom Symptom.Vomiting) "Have you vomited?", tags = "nan" }
    , { value = QuestionSymptom Symptom.NeckStiff, string = "Do you have a stiff neck?", onClick = msg (QuestionSymptom Symptom.NeckStiff) "Do you have a stiff neck?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Diplopia, string = "Do you have double vision?", onClick = msg (QuestionSymptom Symptom.Diplopia) "Do you have double vision?", tags = "nan" }
    , { value = QuestionSymptom Symptom.VisualChange, string = "Are there any changes to your vision?", onClick = msg (QuestionSymptom Symptom.VisualChange) "Are there any changes to your vision?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Photophobia, string = "Do lights make your pain worse?", onClick = msg (QuestionSymptom Symptom.Photophobia) "Do lights make your pain worse?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Rhinorrhoea, string = "Do you have a runny nose?", onClick = msg (QuestionSymptom Symptom.Rhinorrhoea) "Do you have a runny nose?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Cough, string = "Do you have a cough?", onClick = msg (QuestionSymptom Symptom.Cough) "Do you have a cough?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Headache, string = "Do you have a headache?", onClick = msg (QuestionSymptom Symptom.Headache) "Do you have a headache?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Lacrimation, string = "Are your eyes teary?", onClick = msg (QuestionSymptom Symptom.Lacrimation) "Are your eyes teary?", tags = "nan" }
    , { value = QuestionSymptom Symptom.RecentlyIll, string = "Have you been sick recently?", onClick = msg (QuestionSymptom Symptom.RecentlyIll) "Have you been sick recently?", tags = "nan" }
    , { value = QuestionSymptom Symptom.SickContact, string = "Has anyone around you been sick recently?", onClick = msg (QuestionSymptom Symptom.SickContact) "Has anyone around you been sick recently?", tags = "nan" }
    , { value = QuestionSymptom Symptom.SickContact, string = "Have you been in contact with anyone sick?", onClick = msg (QuestionSymptom Symptom.SickContact) "Have you been in contact with anyone sick?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Fever, string = "Do you have a fever?", onClick = msg (QuestionSymptom Symptom.Fever) "Do you have a fever?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Rash, string = "Do you have a rash?", onClick = msg (QuestionSymptom Symptom.Rash) "Do you have a rash?", tags = "nan" }
    , { value = QuestionRashFeature RashFeature.Where, string = "Where is the rash?", onClick = msg (QuestionRashFeature RashFeature.Where) "Where is the rash?", tags = "nan" }
    , { value = QuestionExamine Examine.Rash, string = "Examine the rash.", onClick = msg (QuestionExamine Examine.Rash) "Examine the rash.", tags = "nan" }
    , { value = QuestionSymptom Symptom.ChestPain, string = "Do you have any chest pain?", onClick = msg (QuestionSymptom Symptom.ChestPain) "Do you have any chest pain?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Dyspnoea, string = "Do you feel short of breath?", onClick = msg (QuestionSymptom Symptom.Dyspnoea) "Do you feel short of breath?", tags = "nan" }
    , { value = QuestionDyspnoeaFeature DyspnoeaFeature.Precipitants, string = "What makes you short of breath?", onClick = msg (QuestionDyspnoeaFeature DyspnoeaFeature.Precipitants) "What makes you short of breath?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Palpitations, string = "Do you feel like your heartbeat is abnormal?", onClick = msg (QuestionSymptom Symptom.Palpitations) "Do you feel like your heartbeat is abnormal?", tags = "nan" }
    , { value = QuestionSymptom Symptom.AnkleSwelling, string = "Have your ankles been swollen?", onClick = msg (QuestionSymptom Symptom.AnkleSwelling) "Have your ankles been swollen?", tags = "nan" }
    , { value = QuestionSymptom Symptom.IntermittentClaudication, string = "Do you have pain in your legs when you walk?", onClick = msg (QuestionSymptom Symptom.IntermittentClaudication) "Do you have pain in your legs when you walk?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Orthopnoea, string = "Do you feel short of breath when you lie down?", onClick = msg (QuestionSymptom Symptom.Orthopnoea) "Do you feel short of breath when you lie down?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Pnd, string = "Do you wake up at night gasping for breath?", onClick = msg (QuestionSymptom Symptom.Pnd) "Do you wake up at night gasping for breath?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Loc, string = "Have you fainted?", onClick = msg (QuestionSymptom Symptom.Loc) "Have you fainted?", tags = "syncope" }
    , { value = QuestionSymptom Symptom.Loc, string = "Have you lost consciousness?", onClick = msg (QuestionSymptom Symptom.Loc) "Have you lost consciousness?", tags = "syncope" }
    , { value = QuestionLocFeature LocFeature.When, string = "When did you lose consciousness?", onClick = msg (QuestionLocFeature LocFeature.When) "When did you lose consciousness?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Seizure, string = "Did you have a seizure?", onClick = msg (QuestionSymptom Symptom.Seizure) "Did you have a seizure?", tags = "nan" }
    , { value = QuestionSeizureFeature SeizureFeature.Before, string = "Have you had a seizure before?", onClick = msg (QuestionSeizureFeature SeizureFeature.Before) "Have you had a seizure before?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Fatigue, string = "Do you feel fatigued?", onClick = msg (QuestionSymptom Symptom.Fatigue) "Do you feel fatigued?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Fatigue, string = "Do you feel tired?", onClick = msg (QuestionSymptom Symptom.Fatigue) "Do you feel tired?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Haemoptysis, string = "Have you coughed up any blood?", onClick = msg (QuestionSymptom Symptom.Haemoptysis) "Have you coughed up any blood?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Sputum, string = "Have you coughed up any sputum?", onClick = msg (QuestionSymptom Symptom.Sputum) "Have you coughed up any sputum?", tags = "nan" }
    , { value = QuestionSputumFeature SputumFeature.Volume, string = "How much sputum comes up?", onClick = msg (QuestionSputumFeature SputumFeature.Volume) "How much sputum comes up?", tags = "nan" }
    , { value = QuestionSputumFeature SputumFeature.Colour, string = "What colour is the sputum?", onClick = msg (QuestionSputumFeature SputumFeature.Colour) "What colour is the sputum?", tags = "nan" }
    , { value = QuestionSymptom Symptom.SoreThroat, string = "Do you have a sore throat?", onClick = msg (QuestionSymptom Symptom.SoreThroat) "Do you have a sore throat?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Diaphoresis, string = "Do you feel sweaty?", onClick = msg (QuestionSymptom Symptom.Diaphoresis) "Do you feel sweaty?", tags = "nan" }
    , { value = QuestionSymptom Symptom.JawClaudication, string = "Do you feel any pain when you chew?", onClick = msg (QuestionSymptom Symptom.JawClaudication) "Do you feel any pain when you chew?", tags = "nan" }
    , { value = QuestionSymptom Symptom.VIsualChange, string = "How is your vision?", onClick = msg (QuestionSymptom Symptom.VIsualChange) "How is your vision?", tags = "nan" }
    , { value = QuestionOpen Open.Phx, string = "Do you have any medical conditions?", onClick = msg (QuestionOpen Open.Phx) "Do you have any medical conditions?", tags = "nan" }
    , { value = QuestionPhx Phx.Hypertension, string = "Do you have high blood pressure?", onClick = msg (QuestionPhx Phx.Hypertension) "Do you have high blood pressure?", tags = "nan" }
    , { value = QuestionPhx Phx.Diabetes, string = "Do you have diabetes?", onClick = msg (QuestionPhx Phx.Diabetes) "Do you have diabetes?", tags = "nan" }
    , { value = QuestionPhx Phx.DiabetesType, string = "What type of diabetes do you have?", onClick = msg (QuestionPhx Phx.DiabetesType) "What type of diabetes do you have?", tags = "nan" }
    , { value = QuestionPhx Phx.Surgery, string = "Have you had any surgeries in the past?", onClick = msg (QuestionPhx Phx.Surgery) "Have you had any surgeries in the past?", tags = "nan" }
    , { value = QuestionPhx Phx.Immunisation, string = "Are your immunisations up to date?", onClick = msg (QuestionPhx Phx.Immunisation) "Are your immunisations up to date?", tags = "nan" }
    , { value = QuestionDrugs Drugs.Regular, string = "Are you taking any regular medications?", onClick = msg (QuestionDrugs Drugs.Regular) "Are you taking any regular medications?", tags = "drugs" }
    , { value = QuestionDrugs Drugs.Otc, string = "Are you taking any over the counter medications?", onClick = msg (QuestionDrugs Drugs.Otc) "Are you taking any over the counter medications?", tags = "drugs" }
    , { value = QuestionDrugs Drugs.Recreational, string = "Do you use any recreational drugs?", onClick = msg (QuestionDrugs Drugs.Recreational) "Do you use any recreational drugs?", tags = "nan" }
    , { value = QuestionDrugs Drugs.Allergies, string = "Do you have any allergies, and what reactions do you get?", onClick = msg (QuestionDrugs Drugs.Allergies) "Do you have any allergies, and what reactions do you get?", tags = "nan" }
    , { value = QuestionAlcohol Alcohol.YesNo, string = "Do you drink alcohol?", onClick = msg (QuestionAlcohol Alcohol.YesNo) "Do you drink alcohol?", tags = "nan" }
    , { value = QuestionAlcohol Alcohol.Quantity, string = "How much alcohol do you drink?", onClick = msg (QuestionAlcohol Alcohol.Quantity) "How much alcohol do you drink?", tags = "nan" }
    , { value = QuestionSmoke Smoke.YesNo, string = "Do you smoke?", onClick = msg (QuestionSmoke Smoke.YesNo) "Do you smoke?", tags = "smoking" }
    , { value = QuestionSmoke Smoke.Duration, string = "How long have you smoked for?", onClick = msg (QuestionSmoke Smoke.Duration) "How long have you smoked for?", tags = "nan" }
    , { value = QuestionSmoke Smoke.History, string = "Have you ever smoked?", onClick = msg (QuestionSmoke Smoke.History) "Have you ever smoked?", tags = "nan" }
    , { value = QuestionSmoke Smoke.Quantity, string = "How many cigarettes a day do you or did you smoke?", onClick = msg (QuestionSmoke Smoke.Quantity) "How many cigarettes a day do you or did you smoke?", tags = "nan" }
    , { value = QuestionOpen Open.Fhx, string = "Do any conditions run through the family?", onClick = msg (QuestionOpen Open.Fhx) "Do any conditions run through the family?", tags = "mom mum dad father mother brother sister " }
    , { value = QuestionFhx Fhx.ParentHealth, string = "How are your parents' health?", onClick = msg (QuestionFhx Fhx.ParentHealth) "How are your parents' health?", tags = "mom mum dad father mother" }
    , { value = QuestionFhx Fhx.Children, string = "Do you have any children?", onClick = msg (QuestionFhx Fhx.Children) "Do you have any children?", tags = "kids " }
    , { value = QuestionFhx Fhx.ChildrenHealth, string = "How are your children's health?", onClick = msg (QuestionFhx Fhx.ChildrenHealth) "How are your children's health?", tags = "kids " }
    , { value = QuestionFhx Fhx.Siblings, string = "Do you have any siblings?", onClick = msg (QuestionFhx Fhx.Siblings) "Do you have any siblings?", tags = "brother sister " }
    , { value = QuestionFhx Fhx.SiblingsHealth, string = "How are your siblings' health?", onClick = msg (QuestionFhx Fhx.SiblingsHealth) "How are your siblings' health?", tags = "brother sister " }
    , { value = QuestionShx Shx.LivingPlace, string = "Where do you live at the moment?", onClick = msg (QuestionShx Shx.LivingPlace) "Where do you live at the moment?", tags = "nan" }
    , { value = QuestionShx Shx.LivingPeople, string = "Who do you live with at the moment?", onClick = msg (QuestionShx Shx.LivingPeople) "Who do you live with at the moment?", tags = "nan" }
    , { value = QuestionShx Shx.LivingPeople, string = "Do you live by yourself?", onClick = msg (QuestionShx Shx.LivingPeople) "Do you live by yourself?", tags = "nan" }
    , { value = QuestionShx Shx.Mood, string = "How is your mood?", onClick = msg (QuestionShx Shx.Mood) "How is your mood?", tags = "nan" }
    , { value = QuestionShx Shx.Diet, string = "What are do you usually eat day to day?", onClick = msg (QuestionShx Shx.Diet) "What are do you usually eat day to day?", tags = "nan" }
    , { value = QuestionShx Shx.PhysicalExercise, string = "Do you do physical exercise?", onClick = msg (QuestionShx Shx.PhysicalExercise) "Do you do physical exercise?", tags = "nan" }
    , { value = QuestionShx Shx.Driving, string = "Do you drive?", onClick = msg (QuestionShx Shx.Driving) "Do you drive?", tags = "nan" }
    , { value = QuestionShx Shx.Hobbies, string = "What do you get up to in your spare time?", onClick = msg (QuestionShx Shx.Hobbies) "What do you get up to in your spare time?", tags = "hobbies what do you like interests interested" }
    , { value = QuestionShx Shx.GP, string = "Who is your regular GP?", onClick = msg (QuestionShx Shx.GP) "Who is your regular GP?", tags = "general practitioner doctor primary practitioner usually see" }
    , { value = QuestionExamine Examine.Hands, string = "Examine the hands. ", onClick = msg (QuestionExamine Examine.Hands) "Examine the hands. ", tags = "nan" }
    , { value = QuestionExamine Examine.General, string = "Examine with general inspection.", onClick = msg (QuestionExamine Examine.General) "Examine with general inspection.", tags = "nan" }
    , { value = QuestionExamine Examine.Vitals, string = "Examine the vital signs.", onClick = msg (QuestionExamine Examine.Vitals) "Examine the vital signs.", tags = "vitals hr heart rate bp blood pressure temperature rr respiratory rate" }
    , { value = QuestionExamine Examine.Oxygen, string = "Examine the oxygen saturation (SpO2).", onClick = msg (QuestionExamine Examine.Oxygen) "Examine the oxygen saturation (SpO2).", tags = "nan" }
    , { value = QuestionExamine Examine.GCS, string = "Examine the patient using the Glasgow Coma Scale (GCS).", onClick = msg (QuestionExamine Examine.GCS) "Examine the patient using the Glasgow Coma Scale (GCS).", tags = "nan" }
    , { value = QuestionExamine Examine.Weight, string = "Examine weight.", onClick = msg (QuestionExamine Examine.Weight) "Examine weight.", tags = "nan" }
    , { value = QuestionExamine Examine.Height, string = "Examine height.", onClick = msg (QuestionExamine Examine.Height) "Examine height.", tags = "nan" }
    , { value = QuestionExamine Examine.Surroundings, string = "Examine the surroundings.", onClick = msg (QuestionExamine Examine.Surroundings) "Examine the surroundings.", tags = "nan" }
    , { value = QuestionExamine Examine.Nails, string = "Examine the nails.", onClick = msg (QuestionExamine Examine.Nails) "Examine the nails.", tags = "nan" }
    , { value = QuestionExamine Examine.Arms, string = "Examine the skin overlying the arms.", onClick = msg (QuestionExamine Examine.Arms) "Examine the skin overlying the arms.", tags = "nan" }
    , { value = QuestionExamine Examine.EyeMovements, string = "Examine the eye movements.", onClick = msg (QuestionExamine Examine.EyeMovements) "Examine the eye movements.", tags = "nan" }
    , { value = QuestionExamine Examine.VisualFields, string = "Examine the visual fields with a confrontation test.", onClick = msg (QuestionExamine Examine.VisualFields) "Examine the visual fields with a confrontation test.", tags = "nan" }
    , { value = QuestionExamine Examine.HandMovements, string = "Examine hand movements.", onClick = msg (QuestionExamine Examine.HandMovements) "Examine hand movements.", tags = "nan" }
    , { value = QuestionExamine Examine.Fundus, string = "Examine the fundus with an ophthalmoscope.", onClick = msg (QuestionExamine Examine.Fundus) "Examine the fundus with an ophthalmoscope.", tags = "nan" }
    , { value = QuestionExamine Examine.Snellen, string = "Examine visual acuity with a Snellen chart.", onClick = msg (QuestionExamine Examine.Snellen) "Examine visual acuity with a Snellen chart.", tags = "nan" }
    , { value = QuestionExamine Examine.ECG, string = "Examine electrocardiogram (ECG). ", onClick = msg (QuestionExamine Examine.ECG) "Examine electrocardiogram (ECG). ", tags = "nan" }
    , { value = QuestionSign Sign.Brudzinski, string = "Check for Brudzinski's sign.", onClick = msg (QuestionSign Sign.Brudzinski) "Check for Brudzinski's sign.", tags = "nan" }
    , { value = QuestionSign Sign.Papilloedema, string = "Check for papilloedema.", onClick = msg (QuestionSign Sign.Papilloedema) "Check for papilloedema.", tags = "nan" }
    , { value = QuestionSign Sign.Kernig, string = "Check for Kernig's sign.", onClick = msg (QuestionSign Sign.Kernig) "Check for Kernig's sign.", tags = "nan" }
    , { value = QuestionExamine Examine.Pupils, string = "Examine the pupil reflexes.", onClick = msg (QuestionExamine Examine.Pupils) "Examine the pupil reflexes.", tags = "nan" }
    , { value = QuestionExamine Examine.FacialExpression, string = "Examine the muscles of facial expression.", onClick = msg (QuestionExamine Examine.FacialExpression) "Examine the muscles of facial expression.", tags = "nan" }
    , { value = QuestionExamine Examine.Mastication, string = "Examine the muscles of mastication.", onClick = msg (QuestionExamine Examine.Mastication) "Examine the muscles of mastication.", tags = "nan" }
    , { value = QuestionExamine Examine.Tongue, string = "Examine the tongue.", onClick = msg (QuestionExamine Examine.Tongue) "Examine the tongue.", tags = "nan" }
    , { value = QuestionExamine Examine.OralMucosa, string = "Examine the oral mucosa.", onClick = msg (QuestionExamine Examine.OralMucosa) "Examine the oral mucosa.", tags = "nan" }
    , { value = QuestionSign Sign.PeripheralCyanosis, string = "Check for peripheral cyanosis.", onClick = msg (QuestionSign Sign.PeripheralCyanosis) "Check for peripheral cyanosis.", tags = "nan" }
    , { value = QuestionSign Sign.CentralCyanosis, string = "Check for central cyanosis.", onClick = msg (QuestionSign Sign.CentralCyanosis) "Check for central cyanosis.", tags = "nan" }
    , { value = QuestionExamine Examine.HeartAuscultate, string = "Examine the heart by auscultation.", onClick = msg (QuestionExamine Examine.HeartAuscultate) "Examine the heart by auscultation.", tags = "nan" }
    , { value = QuestionExamine Examine.LungsAuscultate, string = "Examine the lungs by auscultation.", onClick = msg (QuestionExamine Examine.LungsAuscultate) "Examine the lungs by auscultation.", tags = "nan" }
    , { value = QuestionExamine Examine.LungsPercussion, string = "Examine the lungs by percussion.", onClick = msg (QuestionExamine Examine.LungsPercussion) "Examine the lungs by percussion.", tags = "nan" }
    , { value = QuestionExamine Examine.Chest, string = "Examine the external chest.", onClick = msg (QuestionExamine Examine.Chest) "Examine the external chest.", tags = "nan" }
    , { value = QuestionExamine Examine.Neck, string = "Examine the external neck.", onClick = msg (QuestionExamine Examine.Neck) "Examine the external neck.", tags = "nan" }
    , { value = QuestionSign Sign.CarotidBruits, string = "Check for carotid bruits.", onClick = msg (QuestionSign Sign.CarotidBruits) "Check for carotid bruits.", tags = "nan" }
    , { value = QuestionExamine Examine.PowerArms, string = "Examine the power of the arms.", onClick = msg (QuestionExamine Examine.PowerArms) "Examine the power of the arms.", tags = "nan" }
    , { value = QuestionExamine Examine.PowerLegs, string = "Examine the power of the legs.", onClick = msg (QuestionExamine Examine.PowerLegs) "Examine the power of the legs.", tags = "nan" }
    , { value = QuestionExamine Examine.SensationArms, string = "Examine the sensation over the arms.", onClick = msg (QuestionExamine Examine.SensationArms) "Examine the sensation over the arms.", tags = "nan" }
    , { value = QuestionExamine Examine.SensationLegs, string = "Examine the sensation over the legs.", onClick = msg (QuestionExamine Examine.SensationLegs) "Examine the sensation over the legs.", tags = "nan" }
    , { value = QuestionSign Sign.Dysdiado, string = "Check for dysdiadochokinesia.", onClick = msg (QuestionSign Sign.Dysdiado) "Check for dysdiadochokinesia.", tags = "nan" }
    , { value = QuestionSign Sign.IntentionTremo, string = "Check for intention tremor.", onClick = msg (QuestionSign Sign.IntentionTremo) "Check for intention tremor.", tags = "nan" }
    , { value = QuestionExamine Examine.MentalState, string = "Examine the mental state of the patient.", onClick = msg (QuestionExamine Examine.MentalState) "Examine the mental state of the patient.", tags = "nan" } ]

