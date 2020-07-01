module Questions.Question exposing (..)

import Option
import Array exposing (Array)

import Questions.Alcohol as Alcohol exposing (..)
import Questions.Details as Details exposing (..)
import Questions.Drugs as Drugs exposing (..)
import Questions.DyspnoeaFeature as DyspnoeaFeature exposing (..)
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
import Questions.UrinaryFeature as UrinaryFeature exposing (..)
import Questions.Symptom as Symptom exposing (..)
import Questions.SymptomFeature as SymptomFeature exposing (..)

type Question = QuestionAlcohol Alcohol
    | QuestionDetails Details
    | QuestionDrugs Drugs
    | QuestionDyspnoeaFeature DyspnoeaFeature
    | QuestionExamine Examine
    | QuestionFeelings Feelings
    | QuestionFhx Fhx
    | QuestionLocFeature LocFeature
    | QuestionOpen Open
    | QuestionPainFeature PainFeature
    | QuestionPhx Phx
    | QuestionRashFeature RashFeature
    | QuestionSeizureFeature SeizureFeature
    | QuestionShx Shx
    | QuestionSign Sign
    | QuestionSmoke Smoke
    | QuestionSputumFeature SputumFeature
    | QuestionUrinaryFeature UrinaryFeature
    | QuestionSymptom Symptom
    | QuestionSymptomFeature SymptomFeature

fromInt : Int -> Question
fromInt int = 
    case int of
        0 -> QuestionAlcohol Alcohol.YesNo
        1 -> QuestionAlcohol Alcohol.Quantity
        2 -> QuestionDetails Details.Name
        3 -> QuestionDetails Details.Age
        4 -> QuestionDetails Details.Dob
        5 -> QuestionDetails Details.OccupationBrief
        6 -> QuestionDetails Details.OccupationDescription
        7 -> QuestionDrugs Drugs.Regular
        8 -> QuestionDrugs Drugs.Otc
        9 -> QuestionDrugs Drugs.Recreational
        10 -> QuestionDrugs Drugs.Allergies
        11 -> QuestionDyspnoeaFeature DyspnoeaFeature.Precipitants
        12 -> QuestionExamine Examine.Rash
        13 -> QuestionExamine Examine.Hands
        14 -> QuestionExamine Examine.General
        15 -> QuestionExamine Examine.Airway
        16 -> QuestionExamine Examine.Vitals
        17 -> QuestionExamine Examine.Oxygen
        18 -> QuestionExamine Examine.GCS
        19 -> QuestionExamine Examine.Weight
        20 -> QuestionExamine Examine.Height
        21 -> QuestionExamine Examine.Surroundings
        22 -> QuestionExamine Examine.Nails
        23 -> QuestionExamine Examine.Arms
        24 -> QuestionExamine Examine.EyeMovements
        25 -> QuestionExamine Examine.VisualFields
        26 -> QuestionExamine Examine.HandMovements
        27 -> QuestionExamine Examine.Fundus
        28 -> QuestionExamine Examine.Snellen
        29 -> QuestionExamine Examine.ECG
        30 -> QuestionExamine Examine.Pupils
        31 -> QuestionExamine Examine.FacialExpression
        32 -> QuestionExamine Examine.Mastication
        33 -> QuestionExamine Examine.Tongue
        34 -> QuestionExamine Examine.OralMucosa
        35 -> QuestionExamine Examine.HeartAuscultate
        36 -> QuestionExamine Examine.LungsAuscultate
        37 -> QuestionExamine Examine.LungsPercussion
        38 -> QuestionExamine Examine.Chest
        39 -> QuestionExamine Examine.Neck
        40 -> QuestionExamine Examine.PowerArms
        41 -> QuestionExamine Examine.PowerLegs
        42 -> QuestionExamine Examine.SensationArms
        43 -> QuestionExamine Examine.AbdomenInspect
        44 -> QuestionExamine Examine.AbdomenPalpate
        45 -> QuestionExamine Examine.SensationLegs
        46 -> QuestionExamine Examine.MentalState
        47 -> QuestionExamine Examine.BloodGlucose
        48 -> QuestionFeelings Feelings.Beliefs
        49 -> QuestionFeelings Feelings.Impact
        50 -> QuestionFeelings Feelings.Expectations
        51 -> QuestionFeelings Feelings.Concerns
        52 -> QuestionFhx Fhx.ParentHealth
        53 -> QuestionFhx Fhx.Children
        54 -> QuestionFhx Fhx.ChildrenHealth
        55 -> QuestionFhx Fhx.Siblings
        56 -> QuestionFhx Fhx.SiblingsHealth
        57 -> QuestionLocFeature LocFeature.When
        58 -> QuestionOpen Open.Greeting
        59 -> QuestionOpen Open.Opening
        60 -> QuestionOpen Open.More
        61 -> QuestionOpen Open.Symptoms
        62 -> QuestionOpen Open.Phx
        63 -> QuestionOpen Open.Fhx
        64 -> QuestionPainFeature PainFeature.Where
        65 -> QuestionPainFeature PainFeature.Side
        66 -> QuestionPainFeature PainFeature.Activity
        67 -> QuestionPainFeature PainFeature.Onset
        68 -> QuestionPainFeature PainFeature.Timing
        69 -> QuestionPainFeature PainFeature.Quality
        70 -> QuestionPainFeature PainFeature.Quantity
        71 -> QuestionPainFeature PainFeature.Before
        72 -> QuestionPainFeature PainFeature.Triggers
        73 -> QuestionPainFeature PainFeature.Radiation
        74 -> QuestionPhx Phx.Hypertension
        75 -> QuestionPhx Phx.Diabetes
        76 -> QuestionPhx Phx.DiabetesType
        77 -> QuestionPhx Phx.Liver
        78 -> QuestionPhx Phx.Surgery
        79 -> QuestionPhx Phx.Immunisation
        80 -> QuestionRashFeature RashFeature.Where
        81 -> QuestionSeizureFeature SeizureFeature.Before
        82 -> QuestionShx Shx.LivingPlace
        83 -> QuestionShx Shx.LivingPeople
        84 -> QuestionShx Shx.Mood
        85 -> QuestionShx Shx.Diet
        86 -> QuestionShx Shx.PhysicalExercise
        87 -> QuestionShx Shx.Driving
        88 -> QuestionShx Shx.Hobbies
        89 -> QuestionShx Shx.GP
        90 -> QuestionSign Sign.Brudzinski
        91 -> QuestionSign Sign.Papilloedema
        92 -> QuestionSign Sign.Kernig
        93 -> QuestionSign Sign.PeripheralCyanosis
        94 -> QuestionSign Sign.CentralCyanosis
        95 -> QuestionSign Sign.CarotidBruits
        96 -> QuestionSign Sign.Dysdiado
        97 -> QuestionSign Sign.IntentionTremor
        98 -> QuestionSmoke Smoke.YesNo
        99 -> QuestionSmoke Smoke.Duration
        100 -> QuestionSmoke Smoke.History
        101 -> QuestionSmoke Smoke.Quantity
        102 -> QuestionSputumFeature SputumFeature.Volume
        103 -> QuestionSputumFeature SputumFeature.Colour
        104 -> QuestionUrinaryFeature UrinaryFeature.IncontinenceWhen
        105 -> QuestionSymptom Symptom.Pain
        106 -> QuestionSymptom Symptom.Nausea
        107 -> QuestionSymptom Symptom.Vomiting
        108 -> QuestionSymptom Symptom.NeckStiff
        109 -> QuestionSymptom Symptom.Diplopia
        110 -> QuestionSymptom Symptom.VisualChange
        111 -> QuestionSymptom Symptom.Photophobia
        112 -> QuestionSymptom Symptom.Rhinorrhoea
        113 -> QuestionSymptom Symptom.Cough
        114 -> QuestionSymptom Symptom.Headache
        115 -> QuestionSymptom Symptom.Lacrimation
        116 -> QuestionSymptom Symptom.RecentlyIll
        117 -> QuestionSymptom Symptom.SickContact
        118 -> QuestionSymptom Symptom.Travel
        119 -> QuestionSymptom Symptom.Fever
        120 -> QuestionSymptom Symptom.BloodyStools
        121 -> QuestionSymptom Symptom.Rash
        122 -> QuestionSymptom Symptom.BowelHabits
        123 -> QuestionSymptom Symptom.Dysuria
        124 -> QuestionSymptom Symptom.ChestPain
        125 -> QuestionSymptom Symptom.Dyspnoea
        126 -> QuestionSymptom Symptom.Palpitations
        127 -> QuestionSymptom Symptom.AnkleSwelling
        128 -> QuestionSymptom Symptom.IntermittentClaudication
        129 -> QuestionSymptom Symptom.Orthopnoea
        130 -> QuestionSymptom Symptom.Pnd
        131 -> QuestionSymptom Symptom.Loc
        132 -> QuestionSymptom Symptom.Seizure
        133 -> QuestionSymptom Symptom.Fatigue
        134 -> QuestionSymptom Symptom.Haemoptysis
        135 -> QuestionSymptom Symptom.Sputum
        136 -> QuestionSymptom Symptom.SoreThroat
        137 -> QuestionSymptom Symptom.Diaphoresis
        138 -> QuestionSymptom Symptom.JawClaudication
        139 -> QuestionSymptom Symptom.WeightLoss
        140 -> QuestionSymptom Symptom.BloodyUrine
        141 -> QuestionSymptom Symptom.UrinaryIncontinence
        142 -> QuestionSymptomFeature SymptomFeature.When
        143 -> QuestionSymptomFeature SymptomFeature.Precipitants
        144 -> QuestionSymptomFeature SymptomFeature.Quantity
        145 -> QuestionSymptomFeature SymptomFeature.Alleviating
        146 -> QuestionSymptomFeature SymptomFeature.Aggravating
        147 -> QuestionSymptomFeature SymptomFeature.Before
        _ -> QuestionAlcohol Alcohol.YesNo

toInt : Question -> Int
toInt enum = 
    case enum of 
        QuestionAlcohol Alcohol.YesNo -> 0
        QuestionAlcohol Alcohol.Quantity -> 1
        QuestionDetails Details.Name -> 2
        QuestionDetails Details.Age -> 3
        QuestionDetails Details.Dob -> 4
        QuestionDetails Details.OccupationBrief -> 5
        QuestionDetails Details.OccupationDescription -> 6
        QuestionDrugs Drugs.Regular -> 7
        QuestionDrugs Drugs.Otc -> 8
        QuestionDrugs Drugs.Recreational -> 9
        QuestionDrugs Drugs.Allergies -> 10
        QuestionDyspnoeaFeature DyspnoeaFeature.Precipitants -> 11
        QuestionExamine Examine.Rash -> 12
        QuestionExamine Examine.Hands -> 13
        QuestionExamine Examine.General -> 14
        QuestionExamine Examine.Airway -> 15
        QuestionExamine Examine.Vitals -> 16
        QuestionExamine Examine.Oxygen -> 17
        QuestionExamine Examine.GCS -> 18
        QuestionExamine Examine.Weight -> 19
        QuestionExamine Examine.Height -> 20
        QuestionExamine Examine.Surroundings -> 21
        QuestionExamine Examine.Nails -> 22
        QuestionExamine Examine.Arms -> 23
        QuestionExamine Examine.EyeMovements -> 24
        QuestionExamine Examine.VisualFields -> 25
        QuestionExamine Examine.HandMovements -> 26
        QuestionExamine Examine.Fundus -> 27
        QuestionExamine Examine.Snellen -> 28
        QuestionExamine Examine.ECG -> 29
        QuestionExamine Examine.Pupils -> 30
        QuestionExamine Examine.FacialExpression -> 31
        QuestionExamine Examine.Mastication -> 32
        QuestionExamine Examine.Tongue -> 33
        QuestionExamine Examine.OralMucosa -> 34
        QuestionExamine Examine.HeartAuscultate -> 35
        QuestionExamine Examine.LungsAuscultate -> 36
        QuestionExamine Examine.LungsPercussion -> 37
        QuestionExamine Examine.Chest -> 38
        QuestionExamine Examine.Neck -> 39
        QuestionExamine Examine.PowerArms -> 40
        QuestionExamine Examine.PowerLegs -> 41
        QuestionExamine Examine.SensationArms -> 42
        QuestionExamine Examine.AbdomenInspect -> 43
        QuestionExamine Examine.AbdomenPalpate -> 44
        QuestionExamine Examine.SensationLegs -> 45
        QuestionExamine Examine.MentalState -> 46
        QuestionExamine Examine.BloodGlucose -> 47
        QuestionFeelings Feelings.Beliefs -> 48
        QuestionFeelings Feelings.Impact -> 49
        QuestionFeelings Feelings.Expectations -> 50
        QuestionFeelings Feelings.Concerns -> 51
        QuestionFhx Fhx.ParentHealth -> 52
        QuestionFhx Fhx.Children -> 53
        QuestionFhx Fhx.ChildrenHealth -> 54
        QuestionFhx Fhx.Siblings -> 55
        QuestionFhx Fhx.SiblingsHealth -> 56
        QuestionLocFeature LocFeature.When -> 57
        QuestionOpen Open.Greeting -> 58
        QuestionOpen Open.Opening -> 59
        QuestionOpen Open.More -> 60
        QuestionOpen Open.Symptoms -> 61
        QuestionOpen Open.Phx -> 62
        QuestionOpen Open.Fhx -> 63
        QuestionPainFeature PainFeature.Where -> 64
        QuestionPainFeature PainFeature.Side -> 65
        QuestionPainFeature PainFeature.Activity -> 66
        QuestionPainFeature PainFeature.Onset -> 67
        QuestionPainFeature PainFeature.Timing -> 68
        QuestionPainFeature PainFeature.Quality -> 69
        QuestionPainFeature PainFeature.Quantity -> 70
        QuestionPainFeature PainFeature.Before -> 71
        QuestionPainFeature PainFeature.Triggers -> 72
        QuestionPainFeature PainFeature.Radiation -> 73
        QuestionPhx Phx.Hypertension -> 74
        QuestionPhx Phx.Diabetes -> 75
        QuestionPhx Phx.DiabetesType -> 76
        QuestionPhx Phx.Liver -> 77
        QuestionPhx Phx.Surgery -> 78
        QuestionPhx Phx.Immunisation -> 79
        QuestionRashFeature RashFeature.Where -> 80
        QuestionSeizureFeature SeizureFeature.Before -> 81
        QuestionShx Shx.LivingPlace -> 82
        QuestionShx Shx.LivingPeople -> 83
        QuestionShx Shx.Mood -> 84
        QuestionShx Shx.Diet -> 85
        QuestionShx Shx.PhysicalExercise -> 86
        QuestionShx Shx.Driving -> 87
        QuestionShx Shx.Hobbies -> 88
        QuestionShx Shx.GP -> 89
        QuestionSign Sign.Brudzinski -> 90
        QuestionSign Sign.Papilloedema -> 91
        QuestionSign Sign.Kernig -> 92
        QuestionSign Sign.PeripheralCyanosis -> 93
        QuestionSign Sign.CentralCyanosis -> 94
        QuestionSign Sign.CarotidBruits -> 95
        QuestionSign Sign.Dysdiado -> 96
        QuestionSign Sign.IntentionTremor -> 97
        QuestionSmoke Smoke.YesNo -> 98
        QuestionSmoke Smoke.Duration -> 99
        QuestionSmoke Smoke.History -> 100
        QuestionSmoke Smoke.Quantity -> 101
        QuestionSputumFeature SputumFeature.Volume -> 102
        QuestionSputumFeature SputumFeature.Colour -> 103
        QuestionUrinaryFeature UrinaryFeature.IncontinenceWhen -> 104
        QuestionSymptom Symptom.Pain -> 105
        QuestionSymptom Symptom.Nausea -> 106
        QuestionSymptom Symptom.Vomiting -> 107
        QuestionSymptom Symptom.NeckStiff -> 108
        QuestionSymptom Symptom.Diplopia -> 109
        QuestionSymptom Symptom.VisualChange -> 110
        QuestionSymptom Symptom.Photophobia -> 111
        QuestionSymptom Symptom.Rhinorrhoea -> 112
        QuestionSymptom Symptom.Cough -> 113
        QuestionSymptom Symptom.Headache -> 114
        QuestionSymptom Symptom.Lacrimation -> 115
        QuestionSymptom Symptom.RecentlyIll -> 116
        QuestionSymptom Symptom.SickContact -> 117
        QuestionSymptom Symptom.Travel -> 118
        QuestionSymptom Symptom.Fever -> 119
        QuestionSymptom Symptom.BloodyStools -> 120
        QuestionSymptom Symptom.Rash -> 121
        QuestionSymptom Symptom.BowelHabits -> 122
        QuestionSymptom Symptom.Dysuria -> 123
        QuestionSymptom Symptom.ChestPain -> 124
        QuestionSymptom Symptom.Dyspnoea -> 125
        QuestionSymptom Symptom.Palpitations -> 126
        QuestionSymptom Symptom.AnkleSwelling -> 127
        QuestionSymptom Symptom.IntermittentClaudication -> 128
        QuestionSymptom Symptom.Orthopnoea -> 129
        QuestionSymptom Symptom.Pnd -> 130
        QuestionSymptom Symptom.Loc -> 131
        QuestionSymptom Symptom.Seizure -> 132
        QuestionSymptom Symptom.Fatigue -> 133
        QuestionSymptom Symptom.Haemoptysis -> 134
        QuestionSymptom Symptom.Sputum -> 135
        QuestionSymptom Symptom.SoreThroat -> 136
        QuestionSymptom Symptom.Diaphoresis -> 137
        QuestionSymptom Symptom.JawClaudication -> 138
        QuestionSymptom Symptom.WeightLoss -> 139
        QuestionSymptom Symptom.BloodyUrine -> 140
        QuestionSymptom Symptom.UrinaryIncontinence -> 141
        QuestionSymptomFeature SymptomFeature.When -> 142
        QuestionSymptomFeature SymptomFeature.Precipitants -> 143
        QuestionSymptomFeature SymptomFeature.Quantity -> 144
        QuestionSymptomFeature SymptomFeature.Alleviating -> 145
        QuestionSymptomFeature SymptomFeature.Aggravating -> 146
        QuestionSymptomFeature SymptomFeature.Before -> 147

toString : Question -> String
toString enum = 
    case enum of
        QuestionAlcohol Alcohol.YesNo -> "YesNo"
        QuestionAlcohol Alcohol.Quantity -> "Quantity"
        QuestionDetails Details.Name -> "Name"
        QuestionDetails Details.Age -> "Age"
        QuestionDetails Details.Dob -> "Dob"
        QuestionDetails Details.OccupationBrief -> "OccupationBrief"
        QuestionDetails Details.OccupationDescription -> "OccupationDescription"
        QuestionDrugs Drugs.Regular -> "Regular"
        QuestionDrugs Drugs.Otc -> "Otc"
        QuestionDrugs Drugs.Recreational -> "Recreational"
        QuestionDrugs Drugs.Allergies -> "Allergies"
        QuestionDyspnoeaFeature DyspnoeaFeature.Precipitants -> "Precipitants"
        QuestionExamine Examine.Rash -> "Rash"
        QuestionExamine Examine.Hands -> "Hands"
        QuestionExamine Examine.General -> "General"
        QuestionExamine Examine.Airway -> "Airway"
        QuestionExamine Examine.Vitals -> "Vitals"
        QuestionExamine Examine.Oxygen -> "Oxygen"
        QuestionExamine Examine.GCS -> "GCS"
        QuestionExamine Examine.Weight -> "Weight"
        QuestionExamine Examine.Height -> "Height"
        QuestionExamine Examine.Surroundings -> "Surroundings"
        QuestionExamine Examine.Nails -> "Nails"
        QuestionExamine Examine.Arms -> "Arms"
        QuestionExamine Examine.EyeMovements -> "EyeMovements"
        QuestionExamine Examine.VisualFields -> "VisualFields"
        QuestionExamine Examine.HandMovements -> "HandMovements"
        QuestionExamine Examine.Fundus -> "Fundus"
        QuestionExamine Examine.Snellen -> "Snellen"
        QuestionExamine Examine.ECG -> "ECG"
        QuestionExamine Examine.Pupils -> "Pupils"
        QuestionExamine Examine.FacialExpression -> "FacialExpression"
        QuestionExamine Examine.Mastication -> "Mastication"
        QuestionExamine Examine.Tongue -> "Tongue"
        QuestionExamine Examine.OralMucosa -> "OralMucosa"
        QuestionExamine Examine.HeartAuscultate -> "HeartAuscultate"
        QuestionExamine Examine.LungsAuscultate -> "LungsAuscultate"
        QuestionExamine Examine.LungsPercussion -> "LungsPercussion"
        QuestionExamine Examine.Chest -> "Chest"
        QuestionExamine Examine.Neck -> "Neck"
        QuestionExamine Examine.PowerArms -> "PowerArms"
        QuestionExamine Examine.PowerLegs -> "PowerLegs"
        QuestionExamine Examine.SensationArms -> "SensationArms"
        QuestionExamine Examine.AbdomenInspect -> "AbdomenInspect"
        QuestionExamine Examine.AbdomenPalpate -> "AbdomenPalpate"
        QuestionExamine Examine.SensationLegs -> "SensationLegs"
        QuestionExamine Examine.MentalState -> "MentalState"
        QuestionExamine Examine.BloodGlucose -> "BloodGlucose"
        QuestionFeelings Feelings.Beliefs -> "Beliefs"
        QuestionFeelings Feelings.Impact -> "Impact"
        QuestionFeelings Feelings.Expectations -> "Expectations"
        QuestionFeelings Feelings.Concerns -> "Concerns"
        QuestionFhx Fhx.ParentHealth -> "ParentHealth"
        QuestionFhx Fhx.Children -> "Children"
        QuestionFhx Fhx.ChildrenHealth -> "ChildrenHealth"
        QuestionFhx Fhx.Siblings -> "Siblings"
        QuestionFhx Fhx.SiblingsHealth -> "SiblingsHealth"
        QuestionLocFeature LocFeature.When -> "When"
        QuestionOpen Open.Greeting -> "Greeting"
        QuestionOpen Open.Opening -> "Opening"
        QuestionOpen Open.More -> "Opening"
        QuestionOpen Open.Symptoms -> "Opening"
        QuestionOpen Open.Phx -> "More"
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
        QuestionPhx Phx.Hypertension -> "Triggers"
        QuestionPhx Phx.Diabetes -> "Radiation"
        QuestionPhx Phx.DiabetesType -> "Hypertension"
        QuestionPhx Phx.Liver -> "Diabetes"
        QuestionPhx Phx.Surgery -> "DiabetesType"
        QuestionPhx Phx.Immunisation -> "Liver"
        QuestionRashFeature RashFeature.Where -> "Surgery"
        QuestionSeizureFeature SeizureFeature.Before -> "Immunisation"
        QuestionShx Shx.LivingPlace -> "Where"
        QuestionShx Shx.LivingPeople -> "Before"
        QuestionShx Shx.Mood -> "LivingPlace"
        QuestionShx Shx.Diet -> "LivingPeople"
        QuestionShx Shx.PhysicalExercise -> "LivingPeople"
        QuestionShx Shx.Driving -> "Mood"
        QuestionShx Shx.Hobbies -> "Diet"
        QuestionShx Shx.GP -> "PhysicalExercise"
        QuestionSign Sign.Brudzinski -> "Driving"
        QuestionSign Sign.Papilloedema -> "Hobbies"
        QuestionSign Sign.Kernig -> "GP"
        QuestionSign Sign.PeripheralCyanosis -> "Brudzinski"
        QuestionSign Sign.CentralCyanosis -> "Papilloedema"
        QuestionSign Sign.CarotidBruits -> "Kernig"
        QuestionSign Sign.Dysdiado -> "PeripheralCyanosis"
        QuestionSign Sign.IntentionTremor -> "CentralCyanosis"
        QuestionSmoke Smoke.YesNo -> "CarotidBruits"
        QuestionSmoke Smoke.Duration -> "Dysdiado"
        QuestionSmoke Smoke.History -> "IntentionTremor"
        QuestionSmoke Smoke.Quantity -> "YesNo"
        QuestionSputumFeature SputumFeature.Volume -> "Duration"
        QuestionSputumFeature SputumFeature.Colour -> "History"
        QuestionUrinaryFeature UrinaryFeature.IncontinenceWhen -> "Quantity"
        QuestionSymptom Symptom.Pain -> "Volume"
        QuestionSymptom Symptom.Nausea -> "Colour"
        QuestionSymptom Symptom.Vomiting -> "IncontinenceWhen"
        QuestionSymptom Symptom.NeckStiff -> "Pain"
        QuestionSymptom Symptom.Diplopia -> "Nausea"
        QuestionSymptom Symptom.VisualChange -> "Vomiting"
        QuestionSymptom Symptom.Photophobia -> "NeckStiff"
        QuestionSymptom Symptom.Rhinorrhoea -> "Diplopia"
        QuestionSymptom Symptom.Cough -> "VisualChange"
        QuestionSymptom Symptom.Headache -> "Photophobia"
        QuestionSymptom Symptom.Lacrimation -> "Rhinorrhoea"
        QuestionSymptom Symptom.RecentlyIll -> "Cough"
        QuestionSymptom Symptom.SickContact -> "Headache"
        QuestionSymptom Symptom.Travel -> "Lacrimation"
        QuestionSymptom Symptom.Fever -> "RecentlyIll"
        QuestionSymptom Symptom.BloodyStools -> "SickContact"
        QuestionSymptom Symptom.Rash -> "Travel"
        QuestionSymptom Symptom.BowelHabits -> "Fever"
        QuestionSymptom Symptom.Dysuria -> "BloodyStools"
        QuestionSymptom Symptom.ChestPain -> "Rash"
        QuestionSymptom Symptom.Dyspnoea -> "BowelHabits"
        QuestionSymptom Symptom.Palpitations -> "Dysuria"
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
        QuestionSymptom Symptom.WeightLoss -> "Haemoptysis"
        QuestionSymptom Symptom.BloodyUrine -> "Sputum"
        QuestionSymptom Symptom.UrinaryIncontinence -> "SoreThroat"
        QuestionSymptomFeature SymptomFeature.When -> "Diaphoresis"
        QuestionSymptomFeature SymptomFeature.Precipitants -> "JawClaudication"
        QuestionSymptomFeature SymptomFeature.Quantity -> "VisualChange"
        QuestionSymptomFeature SymptomFeature.Alleviating -> "WeightLoss"
        QuestionSymptomFeature SymptomFeature.Aggravating -> "BloodyUrine"
        QuestionSymptomFeature SymptomFeature.Before -> "UrinaryIncontinence"

list : List Question
list = 
    [ QuestionAlcohol Alcohol.YesNo
    , QuestionAlcohol Alcohol.Quantity
    , QuestionDetails Details.Name
    , QuestionDetails Details.Age
    , QuestionDetails Details.Dob
    , QuestionDetails Details.OccupationBrief
    , QuestionDetails Details.OccupationDescription
    , QuestionDrugs Drugs.Regular
    , QuestionDrugs Drugs.Otc
    , QuestionDrugs Drugs.Recreational
    , QuestionDrugs Drugs.Allergies
    , QuestionDyspnoeaFeature DyspnoeaFeature.Precipitants
    , QuestionExamine Examine.Rash
    , QuestionExamine Examine.Hands
    , QuestionExamine Examine.General
    , QuestionExamine Examine.Airway
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
    , QuestionExamine Examine.AbdomenInspect
    , QuestionExamine Examine.AbdomenPalpate
    , QuestionExamine Examine.SensationLegs
    , QuestionExamine Examine.MentalState
    , QuestionExamine Examine.BloodGlucose
    , QuestionFeelings Feelings.Beliefs
    , QuestionFeelings Feelings.Impact
    , QuestionFeelings Feelings.Expectations
    , QuestionFeelings Feelings.Concerns
    , QuestionFhx Fhx.ParentHealth
    , QuestionFhx Fhx.Children
    , QuestionFhx Fhx.ChildrenHealth
    , QuestionFhx Fhx.Siblings
    , QuestionFhx Fhx.SiblingsHealth
    , QuestionLocFeature LocFeature.When
    , QuestionOpen Open.Greeting
    , QuestionOpen Open.Opening
    , QuestionOpen Open.More
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
    , QuestionPhx Phx.Hypertension
    , QuestionPhx Phx.Diabetes
    , QuestionPhx Phx.DiabetesType
    , QuestionPhx Phx.Liver
    , QuestionPhx Phx.Surgery
    , QuestionPhx Phx.Immunisation
    , QuestionRashFeature RashFeature.Where
    , QuestionSeizureFeature SeizureFeature.Before
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
    , QuestionSign Sign.IntentionTremor
    , QuestionSmoke Smoke.YesNo
    , QuestionSmoke Smoke.Duration
    , QuestionSmoke Smoke.History
    , QuestionSmoke Smoke.Quantity
    , QuestionSputumFeature SputumFeature.Volume
    , QuestionSputumFeature SputumFeature.Colour
    , QuestionUrinaryFeature UrinaryFeature.IncontinenceWhen
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
    , QuestionSymptom Symptom.Travel
    , QuestionSymptom Symptom.Fever
    , QuestionSymptom Symptom.BloodyStools
    , QuestionSymptom Symptom.Rash
    , QuestionSymptom Symptom.BowelHabits
    , QuestionSymptom Symptom.Dysuria
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
    , QuestionSymptom Symptom.WeightLoss
    , QuestionSymptom Symptom.BloodyUrine
    , QuestionSymptom Symptom.UrinaryIncontinence
    , QuestionSymptomFeature SymptomFeature.When
    , QuestionSymptomFeature SymptomFeature.Precipitants
    , QuestionSymptomFeature SymptomFeature.Quantity
    , QuestionSymptomFeature SymptomFeature.Alleviating
    , QuestionSymptomFeature SymptomFeature.Aggravating
    , QuestionSymptomFeature SymptomFeature.Before ]

optionList : (Question -> String -> msg) -> List (Option.Data Question msg)
optionList msg =
    [ { value = QuestionAlcohol Alcohol.YesNo, string = "Do you drink alcohol?", onClick = msg (QuestionAlcohol Alcohol.YesNo) "Do you drink alcohol?", tags = "nan" }
    , { value = QuestionAlcohol Alcohol.Quantity, string = "How much alcohol do you drink?", onClick = msg (QuestionAlcohol Alcohol.Quantity) "How much alcohol do you drink?", tags = "nan" }
    , { value = QuestionDetails Details.Name, string = "What is your name?", onClick = msg (QuestionDetails Details.Name) "What is your name?", tags = "name" }
    , { value = QuestionDetails Details.Age, string = "How old are you?", onClick = msg (QuestionDetails Details.Age) "How old are you?", tags = "nan" }
    , { value = QuestionDetails Details.Dob, string = "When were you born?", onClick = msg (QuestionDetails Details.Dob) "When were you born?", tags = "date of birth dob" }
    , { value = QuestionDetails Details.OccupationBrief, string = "Do you work?", onClick = msg (QuestionDetails Details.OccupationBrief) "Do you work?", tags = "employed job" }
    , { value = QuestionDetails Details.OccupationDescription, string = "What do you work as?", onClick = msg (QuestionDetails Details.OccupationDescription) "What do you work as?", tags = "job what do you do for work what's your job what are you employed as" }
    , { value = QuestionDrugs Drugs.Regular, string = "Are you taking any regular medications?", onClick = msg (QuestionDrugs Drugs.Regular) "Are you taking any regular medications?", tags = "drugs" }
    , { value = QuestionDrugs Drugs.Otc, string = "Are you taking any over the counter medications?", onClick = msg (QuestionDrugs Drugs.Otc) "Are you taking any over the counter medications?", tags = "drugs" }
    , { value = QuestionDrugs Drugs.Recreational, string = "Do you use any recreational drugs?", onClick = msg (QuestionDrugs Drugs.Recreational) "Do you use any recreational drugs?", tags = "nan" }
    , { value = QuestionDrugs Drugs.Allergies, string = "Do you have any allergies, and what reactions do you get?", onClick = msg (QuestionDrugs Drugs.Allergies) "Do you have any allergies, and what reactions do you get?", tags = "are you allergic allergy adverse drug reaction" }
    , { value = QuestionDyspnoeaFeature DyspnoeaFeature.Precipitants, string = "What makes you short of breath?", onClick = msg (QuestionDyspnoeaFeature DyspnoeaFeature.Precipitants) "What makes you short of breath?", tags = "precipitate" }
    , { value = QuestionExamine Examine.Rash, string = "Examine the rash.", onClick = msg (QuestionExamine Examine.Rash) "Examine the rash.", tags = "nan" }
    , { value = QuestionExamine Examine.Hands, string = "Examine the hands. ", onClick = msg (QuestionExamine Examine.Hands) "Examine the hands. ", tags = "nan" }
    , { value = QuestionExamine Examine.General, string = "Examine with general inspection.", onClick = msg (QuestionExamine Examine.General) "Examine with general inspection.", tags = "nan" }
    , { value = QuestionExamine Examine.Airway, string = "Examine the patient's airway.", onClick = msg (QuestionExamine Examine.Airway) "Examine the patient's airway.", tags = "airway" }
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
    , { value = QuestionExamine Examine.Pupils, string = "Examine the pupil reflexes.", onClick = msg (QuestionExamine Examine.Pupils) "Examine the pupil reflexes.", tags = "nan" }
    , { value = QuestionExamine Examine.FacialExpression, string = "Examine the muscles of facial expression.", onClick = msg (QuestionExamine Examine.FacialExpression) "Examine the muscles of facial expression.", tags = "nan" }
    , { value = QuestionExamine Examine.Mastication, string = "Examine the muscles of mastication.", onClick = msg (QuestionExamine Examine.Mastication) "Examine the muscles of mastication.", tags = "nan" }
    , { value = QuestionExamine Examine.Tongue, string = "Examine the tongue.", onClick = msg (QuestionExamine Examine.Tongue) "Examine the tongue.", tags = "nan" }
    , { value = QuestionExamine Examine.OralMucosa, string = "Examine the oral mucosa.", onClick = msg (QuestionExamine Examine.OralMucosa) "Examine the oral mucosa.", tags = "nan" }
    , { value = QuestionExamine Examine.HeartAuscultate, string = "Examine the heart by auscultation.", onClick = msg (QuestionExamine Examine.HeartAuscultate) "Examine the heart by auscultation.", tags = "auscultate listen to the chest " }
    , { value = QuestionExamine Examine.LungsAuscultate, string = "Examine the lungs by auscultation.", onClick = msg (QuestionExamine Examine.LungsAuscultate) "Examine the lungs by auscultation.", tags = "auscultate listen to the chest " }
    , { value = QuestionExamine Examine.LungsPercussion, string = "Examine the lungs by percussion.", onClick = msg (QuestionExamine Examine.LungsPercussion) "Examine the lungs by percussion.", tags = "nan" }
    , { value = QuestionExamine Examine.Chest, string = "Examine the external chest.", onClick = msg (QuestionExamine Examine.Chest) "Examine the external chest.", tags = "nan" }
    , { value = QuestionExamine Examine.Neck, string = "Examine the external neck.", onClick = msg (QuestionExamine Examine.Neck) "Examine the external neck.", tags = "nan" }
    , { value = QuestionExamine Examine.PowerArms, string = "Examine the power of the arms.", onClick = msg (QuestionExamine Examine.PowerArms) "Examine the power of the arms.", tags = "nan" }
    , { value = QuestionExamine Examine.PowerLegs, string = "Examine the power of the legs.", onClick = msg (QuestionExamine Examine.PowerLegs) "Examine the power of the legs.", tags = "nan" }
    , { value = QuestionExamine Examine.SensationArms, string = "Examine the sensation over the arms.", onClick = msg (QuestionExamine Examine.SensationArms) "Examine the sensation over the arms.", tags = "nan" }
    , { value = QuestionExamine Examine.AbdomenInspect, string = "Examine the abdomen by inspecting.", onClick = msg (QuestionExamine Examine.AbdomenInspect) "Examine the abdomen by inspecting.", tags = "nan" }
    , { value = QuestionExamine Examine.AbdomenPalpate, string = "Examine the abdomen with superficial and deep palpation.", onClick = msg (QuestionExamine Examine.AbdomenPalpate) "Examine the abdomen with superficial and deep palpation.", tags = "nan" }
    , { value = QuestionExamine Examine.SensationLegs, string = "Examine the sensation over the legs.", onClick = msg (QuestionExamine Examine.SensationLegs) "Examine the sensation over the legs.", tags = "nan" }
    , { value = QuestionExamine Examine.MentalState, string = "Examine the mental state of the patient.", onClick = msg (QuestionExamine Examine.MentalState) "Examine the mental state of the patient.", tags = "nan" }
    , { value = QuestionExamine Examine.BloodGlucose, string = "Test the patient's random blood glucose.", onClick = msg (QuestionExamine Examine.BloodGlucose) "Test the patient's random blood glucose.", tags = "glucometer bsl glucose sugars" }
    , { value = QuestionFeelings Feelings.Beliefs, string = "What do you believe is causing your symptoms?", onClick = msg (QuestionFeelings Feelings.Beliefs) "What do you believe is causing your symptoms?", tags = "nan" }
    , { value = QuestionFeelings Feelings.Impact, string = "How are your symptoms impacting you?", onClick = msg (QuestionFeelings Feelings.Impact) "How are your symptoms impacting you?", tags = "nan" }
    , { value = QuestionFeelings Feelings.Expectations, string = "What are you expectations from our consultation today?", onClick = msg (QuestionFeelings Feelings.Expectations) "What are you expectations from our consultation today?", tags = "nan" }
    , { value = QuestionFeelings Feelings.Concerns, string = "What are you most concerned about?", onClick = msg (QuestionFeelings Feelings.Concerns) "What are you most concerned about?", tags = "nan" }
    , { value = QuestionFhx Fhx.ParentHealth, string = "How are your parents' health?", onClick = msg (QuestionFhx Fhx.ParentHealth) "How are your parents' health?", tags = "mom mum dad father mother" }
    , { value = QuestionFhx Fhx.Children, string = "Do you have any children?", onClick = msg (QuestionFhx Fhx.Children) "Do you have any children?", tags = "kids " }
    , { value = QuestionFhx Fhx.ChildrenHealth, string = "How are your children's health?", onClick = msg (QuestionFhx Fhx.ChildrenHealth) "How are your children's health?", tags = "kids " }
    , { value = QuestionFhx Fhx.Siblings, string = "Do you have any siblings?", onClick = msg (QuestionFhx Fhx.Siblings) "Do you have any siblings?", tags = "brother sister " }
    , { value = QuestionFhx Fhx.SiblingsHealth, string = "How are your siblings' health?", onClick = msg (QuestionFhx Fhx.SiblingsHealth) "How are your siblings' health?", tags = "brother sister " }
    , { value = QuestionLocFeature LocFeature.When, string = "When did you lose consciousness?", onClick = msg (QuestionLocFeature LocFeature.When) "When did you lose consciousness?", tags = "nan" }
    , { value = QuestionOpen Open.Greeting, string = "Hi. It's nice to meet you.", onClick = msg (QuestionOpen Open.Greeting) "Hi. It's nice to meet you.", tags = "hi hello nice to meet you good morning good afternoon" }
    , { value = QuestionOpen Open.Opening, string = "What's brought you in today?", onClick = msg (QuestionOpen Open.Opening) "What's brought you in today?", tags = "what brought you how can I help" }
    , { value = QuestionOpen Open.Opening, string = "Why have you come to see us today?", onClick = msg (QuestionOpen Open.Opening) "Why have you come to see us today?", tags = "why did you come" }
    , { value = QuestionOpen Open.Opening, string = "How can I help you today?", onClick = msg (QuestionOpen Open.Opening) "How can I help you today?", tags = "nan" }
    , { value = QuestionOpen Open.More, string = "Tell me more.", onClick = msg (QuestionOpen Open.More) "Tell me more.", tags = "nan" }
    , { value = QuestionOpen Open.Symptoms, string = "What other symptoms do you have?", onClick = msg (QuestionOpen Open.Symptoms) "What other symptoms do you have?", tags = "nan" }
    , { value = QuestionOpen Open.Phx, string = "Do you have any medical conditions?", onClick = msg (QuestionOpen Open.Phx) "Do you have any medical conditions?", tags = "nan" }
    , { value = QuestionOpen Open.Fhx, string = "Do any conditions run through the family?", onClick = msg (QuestionOpen Open.Fhx) "Do any conditions run through the family?", tags = "mom mum dad father mother brother sister " }
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
    , { value = QuestionPhx Phx.Hypertension, string = "Do you have high blood pressure?", onClick = msg (QuestionPhx Phx.Hypertension) "Do you have high blood pressure?", tags = "nan" }
    , { value = QuestionPhx Phx.Diabetes, string = "Do you have diabetes?", onClick = msg (QuestionPhx Phx.Diabetes) "Do you have diabetes?", tags = "nan" }
    , { value = QuestionPhx Phx.DiabetesType, string = "What type of diabetes do you have?", onClick = msg (QuestionPhx Phx.DiabetesType) "What type of diabetes do you have?", tags = "nan" }
    , { value = QuestionPhx Phx.Liver, string = "Do you have any issues with your liver?", onClick = msg (QuestionPhx Phx.Liver) "Do you have any issues with your liver?", tags = "liver disease cirrhosis " }
    , { value = QuestionPhx Phx.Surgery, string = "Have you had any surgeries in the past?", onClick = msg (QuestionPhx Phx.Surgery) "Have you had any surgeries in the past?", tags = "nan" }
    , { value = QuestionPhx Phx.Immunisation, string = "Are your immunisations up to date?", onClick = msg (QuestionPhx Phx.Immunisation) "Are your immunisations up to date?", tags = "nan" }
    , { value = QuestionRashFeature RashFeature.Where, string = "Where is the rash?", onClick = msg (QuestionRashFeature RashFeature.Where) "Where is the rash?", tags = "nan" }
    , { value = QuestionSeizureFeature SeizureFeature.Before, string = "Have you had a seizure before?", onClick = msg (QuestionSeizureFeature SeizureFeature.Before) "Have you had a seizure before?", tags = "nan" }
    , { value = QuestionShx Shx.LivingPlace, string = "Where do you live at the moment?", onClick = msg (QuestionShx Shx.LivingPlace) "Where do you live at the moment?", tags = "nan" }
    , { value = QuestionShx Shx.LivingPeople, string = "Who do you live with at the moment?", onClick = msg (QuestionShx Shx.LivingPeople) "Who do you live with at the moment?", tags = "nan" }
    , { value = QuestionShx Shx.LivingPeople, string = "Do you live by yourself?", onClick = msg (QuestionShx Shx.LivingPeople) "Do you live by yourself?", tags = "nan" }
    , { value = QuestionShx Shx.Mood, string = "How is your mood?", onClick = msg (QuestionShx Shx.Mood) "How is your mood?", tags = "nan" }
    , { value = QuestionShx Shx.Diet, string = "What are do you usually eat day to day?", onClick = msg (QuestionShx Shx.Diet) "What are do you usually eat day to day?", tags = "nan" }
    , { value = QuestionShx Shx.PhysicalExercise, string = "Do you do physical exercise?", onClick = msg (QuestionShx Shx.PhysicalExercise) "Do you do physical exercise?", tags = "nan" }
    , { value = QuestionShx Shx.Driving, string = "Do you drive?", onClick = msg (QuestionShx Shx.Driving) "Do you drive?", tags = "nan" }
    , { value = QuestionShx Shx.Hobbies, string = "What do you get up to in your spare time?", onClick = msg (QuestionShx Shx.Hobbies) "What do you get up to in your spare time?", tags = "hobbies what do you like interests interested" }
    , { value = QuestionShx Shx.GP, string = "Who is your regular GP?", onClick = msg (QuestionShx Shx.GP) "Who is your regular GP?", tags = "general practitioner doctor primary practitioner usually see" }
    , { value = QuestionSign Sign.Brudzinski, string = "Check for Brudzinski's sign.", onClick = msg (QuestionSign Sign.Brudzinski) "Check for Brudzinski's sign.", tags = "nan" }
    , { value = QuestionSign Sign.Papilloedema, string = "Check for papilloedema.", onClick = msg (QuestionSign Sign.Papilloedema) "Check for papilloedema.", tags = "nan" }
    , { value = QuestionSign Sign.Kernig, string = "Check for Kernig's sign.", onClick = msg (QuestionSign Sign.Kernig) "Check for Kernig's sign.", tags = "nan" }
    , { value = QuestionSign Sign.PeripheralCyanosis, string = "Check for peripheral cyanosis.", onClick = msg (QuestionSign Sign.PeripheralCyanosis) "Check for peripheral cyanosis.", tags = "nan" }
    , { value = QuestionSign Sign.CentralCyanosis, string = "Check for central cyanosis.", onClick = msg (QuestionSign Sign.CentralCyanosis) "Check for central cyanosis.", tags = "nan" }
    , { value = QuestionSign Sign.CarotidBruits, string = "Check for carotid bruits.", onClick = msg (QuestionSign Sign.CarotidBruits) "Check for carotid bruits.", tags = "nan" }
    , { value = QuestionSign Sign.Dysdiado, string = "Check for dysdiadochokinesia.", onClick = msg (QuestionSign Sign.Dysdiado) "Check for dysdiadochokinesia.", tags = "nan" }
    , { value = QuestionSign Sign.IntentionTremor, string = "Check for intention tremor.", onClick = msg (QuestionSign Sign.IntentionTremor) "Check for intention tremor.", tags = "nan" }
    , { value = QuestionSmoke Smoke.YesNo, string = "Do you smoke?", onClick = msg (QuestionSmoke Smoke.YesNo) "Do you smoke?", tags = "smoking" }
    , { value = QuestionSmoke Smoke.Duration, string = "How long have you smoked for?", onClick = msg (QuestionSmoke Smoke.Duration) "How long have you smoked for?", tags = "nan" }
    , { value = QuestionSmoke Smoke.History, string = "Have you ever smoked?", onClick = msg (QuestionSmoke Smoke.History) "Have you ever smoked?", tags = "nan" }
    , { value = QuestionSmoke Smoke.Quantity, string = "How many cigarettes a day do you or did you smoke?", onClick = msg (QuestionSmoke Smoke.Quantity) "How many cigarettes a day do you or did you smoke?", tags = "nan" }
    , { value = QuestionSputumFeature SputumFeature.Volume, string = "How much sputum comes up?", onClick = msg (QuestionSputumFeature SputumFeature.Volume) "How much sputum comes up?", tags = "nan" }
    , { value = QuestionSputumFeature SputumFeature.Colour, string = "What colour is the sputum?", onClick = msg (QuestionSputumFeature SputumFeature.Colour) "What colour is the sputum?", tags = "nan" }
    , { value = QuestionUrinaryFeature UrinaryFeature.IncontinenceWhen, string = "When are or were you incontinent of urine?", onClick = msg (QuestionUrinaryFeature UrinaryFeature.IncontinenceWhen) "When are or were you incontinent of urine?", tags = "frequency urge stress incontinence" }
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
    , { value = QuestionSymptom Symptom.SickContact, string = "Have you been in contact with anyone sick?", onClick = msg (QuestionSymptom Symptom.SickContact) "Have you been in contact with anyone sick?", tags = "close contact sick contact" }
    , { value = QuestionSymptom Symptom.Travel, string = "Have you been travelling recently?", onClick = msg (QuestionSymptom Symptom.Travel) "Have you been travelling recently?", tags = "have you been overseas flights plane country" }
    , { value = QuestionSymptom Symptom.Fever, string = "Do you have a fever?", onClick = msg (QuestionSymptom Symptom.Fever) "Do you have a fever?", tags = "nan" }
    , { value = QuestionSymptom Symptom.BloodyStools, string = "Have you had any blood in your stools?", onClick = msg (QuestionSymptom Symptom.BloodyStools) "Have you had any blood in your stools?", tags = "gi bleeding poo melaena melena bleeding per rectum" }
    , { value = QuestionSymptom Symptom.Rash, string = "Do you have a rash?", onClick = msg (QuestionSymptom Symptom.Rash) "Do you have a rash?", tags = "nan" }
    , { value = QuestionSymptom Symptom.BowelHabits, string = "Have you had any changes to your bowel habits?", onClick = msg (QuestionSymptom Symptom.BowelHabits) "Have you had any changes to your bowel habits?", tags = "diarrhoea constipation diarrhea constipated frequency bowel motions go to the toilet poo " }
    , { value = QuestionSymptom Symptom.Dysuria, string = "Have you noticed any pain when you urinate?", onClick = msg (QuestionSymptom Symptom.Dysuria) "Have you noticed any pain when you urinate?", tags = "dysuria pain on urination pee go to the toilet " }
    , { value = QuestionSymptom Symptom.ChestPain, string = "Do you have any chest pain?", onClick = msg (QuestionSymptom Symptom.ChestPain) "Do you have any chest pain?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Dyspnoea, string = "Do you feel short of breath?", onClick = msg (QuestionSymptom Symptom.Dyspnoea) "Do you feel short of breath?", tags = "short of breath sob soboe dyspnoea dyspnea" }
    , { value = QuestionSymptom Symptom.Palpitations, string = "Do you feel like your heartbeat is abnormal?", onClick = msg (QuestionSymptom Symptom.Palpitations) "Do you feel like your heartbeat is abnormal?", tags = "palpitations" }
    , { value = QuestionSymptom Symptom.AnkleSwelling, string = "Have your ankles been swollen?", onClick = msg (QuestionSymptom Symptom.AnkleSwelling) "Have your ankles been swollen?", tags = "nan" }
    , { value = QuestionSymptom Symptom.IntermittentClaudication, string = "Do you have pain in your legs when you walk?", onClick = msg (QuestionSymptom Symptom.IntermittentClaudication) "Do you have pain in your legs when you walk?", tags = "intermittent claudication" }
    , { value = QuestionSymptom Symptom.Orthopnoea, string = "Do you feel short of breath when you lie down?", onClick = msg (QuestionSymptom Symptom.Orthopnoea) "Do you feel short of breath when you lie down?", tags = "orthopnoea" }
    , { value = QuestionSymptom Symptom.Pnd, string = "Do you wake up at night gasping for breath?", onClick = msg (QuestionSymptom Symptom.Pnd) "Do you wake up at night gasping for breath?", tags = "pnd paroxysmal nocturnal dyspnoea" }
    , { value = QuestionSymptom Symptom.Loc, string = "Have you fainted?", onClick = msg (QuestionSymptom Symptom.Loc) "Have you fainted?", tags = "syncope" }
    , { value = QuestionSymptom Symptom.Loc, string = "Have you lost consciousness?", onClick = msg (QuestionSymptom Symptom.Loc) "Have you lost consciousness?", tags = "syncope" }
    , { value = QuestionSymptom Symptom.Seizure, string = "Did you have a seizure?", onClick = msg (QuestionSymptom Symptom.Seizure) "Did you have a seizure?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Fatigue, string = "Do you feel fatigued?", onClick = msg (QuestionSymptom Symptom.Fatigue) "Do you feel fatigued?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Fatigue, string = "Do you feel tired?", onClick = msg (QuestionSymptom Symptom.Fatigue) "Do you feel tired?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Haemoptysis, string = "Have you coughed up any blood?", onClick = msg (QuestionSymptom Symptom.Haemoptysis) "Have you coughed up any blood?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Sputum, string = "Have you coughed up any sputum?", onClick = msg (QuestionSymptom Symptom.Sputum) "Have you coughed up any sputum?", tags = "nan" }
    , { value = QuestionSymptom Symptom.SoreThroat, string = "Do you have a sore throat?", onClick = msg (QuestionSymptom Symptom.SoreThroat) "Do you have a sore throat?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Diaphoresis, string = "Do you feel sweaty?", onClick = msg (QuestionSymptom Symptom.Diaphoresis) "Do you feel sweaty?", tags = "nan" }
    , { value = QuestionSymptom Symptom.JawClaudication, string = "Do you feel any pain when you chew?", onClick = msg (QuestionSymptom Symptom.JawClaudication) "Do you feel any pain when you chew?", tags = "nan" }
    , { value = QuestionSymptom Symptom.VisualChange, string = "How is your vision?", onClick = msg (QuestionSymptom Symptom.VisualChange) "How is your vision?", tags = "nan" }
    , { value = QuestionSymptom Symptom.WeightLoss, string = "Have you lost weight recently?", onClick = msg (QuestionSymptom Symptom.WeightLoss) "Have you lost weight recently?", tags = "have you noticed any weight loss weight change" }
    , { value = QuestionSymptom Symptom.BloodyUrine, string = "Have you noticed any blood in your urine?", onClick = msg (QuestionSymptom Symptom.BloodyUrine) "Have you noticed any blood in your urine?", tags = "haematuria hematuria" }
    , { value = QuestionSymptom Symptom.UrinaryIncontinence, string = "Have you been incontinent of urine?", onClick = msg (QuestionSymptom Symptom.UrinaryIncontinence) "Have you been incontinent of urine?", tags = "incontinence frequency urge dribble" }
    , { value = QuestionSymptomFeature SymptomFeature.When, string = "When did your symptoms start?", onClick = msg (QuestionSymptomFeature SymptomFeature.When) "When did your symptoms start?", tags = "nan" }
    , { value = QuestionSymptomFeature SymptomFeature.Precipitants, string = "Did anything happen around the time your symptoms started?", onClick = msg (QuestionSymptomFeature SymptomFeature.Precipitants) "Did anything happen around the time your symptoms started?", tags = "precipitate what were you doing when start" }
    , { value = QuestionSymptomFeature SymptomFeature.Quantity, string = "How severe are your symptoms?", onClick = msg (QuestionSymptomFeature SymptomFeature.Quantity) "How severe are your symptoms?", tags = "nan" }
    , { value = QuestionSymptomFeature SymptomFeature.Alleviating, string = "Does anything make it better?", onClick = msg (QuestionSymptomFeature SymptomFeature.Alleviating) "Does anything make it better?", tags = "nan" }
    , { value = QuestionSymptomFeature SymptomFeature.Aggravating, string = "Does anything make it worse?", onClick = msg (QuestionSymptomFeature SymptomFeature.Aggravating) "Does anything make it worse?", tags = "nan" }
    , { value = QuestionSymptomFeature SymptomFeature.Before, string = "Have you ever had these symtoms before?", onClick = msg (QuestionSymptomFeature SymptomFeature.Before) "Have you ever had these symtoms before?", tags = "nan" } ]

