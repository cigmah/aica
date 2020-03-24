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
        2 -> QuestionDetails Details.OccupationBrief
        3 -> QuestionDetails Details.OccupationDescription
        4 -> QuestionOpen Open.Opening
        5 -> QuestionOpen Open.Symptoms
        6 -> QuestionOpen Open.Phx
        7 -> QuestionOpen Open.Fhx
        8 -> QuestionPainFeature PainFeature.Where
        9 -> QuestionPainFeature PainFeature.Side
        10 -> QuestionPainFeature PainFeature.Onset
        11 -> QuestionPainFeature PainFeature.Timing
        12 -> QuestionPainFeature PainFeature.Quality
        13 -> QuestionPainFeature PainFeature.Quantity
        14 -> QuestionPainFeature PainFeature.Before
        15 -> QuestionPainFeature PainFeature.Triggers
        16 -> QuestionPainFeature PainFeature.Radiation
        17 -> QuestionSymptomFeature SymptomFeature.When
        18 -> QuestionSymptomFeature SymptomFeature.Quantity
        19 -> QuestionSymptomFeature SymptomFeature.Alleviating
        20 -> QuestionSymptomFeature SymptomFeature.Aggravating
        21 -> QuestionFeelings Feelings.Beliefs
        22 -> QuestionFeelings Feelings.Impact
        23 -> QuestionFeelings Feelings.Expectations
        24 -> QuestionFeelings Feelings.Concerns
        25 -> QuestionSymptom Symptom.Pain
        26 -> QuestionSymptom Symptom.Nausea
        27 -> QuestionSymptom Symptom.Vomiting
        28 -> QuestionSymptom Symptom.NeckStiff
        29 -> QuestionSymptom Symptom.Diplopia
        30 -> QuestionSymptom Symptom.VisualChange
        31 -> QuestionSymptom Symptom.Photophobia
        32 -> QuestionSymptom Symptom.Rhinorrhoea
        33 -> QuestionSymptom Symptom.Cough
        34 -> QuestionSymptom Symptom.Headache
        35 -> QuestionSymptom Symptom.Lacrimation
        36 -> QuestionSymptom Symptom.RecentlyIll
        37 -> QuestionSymptom Symptom.SickContact
        38 -> QuestionSymptom Symptom.Fever
        39 -> QuestionSymptom Symptom.Rash
        40 -> QuestionSymptom Symptom.ChestPain
        41 -> QuestionSymptom Symptom.Dyspnoea
        42 -> QuestionSymptom Symptom.Palpitations
        43 -> QuestionSymptom Symptom.AnkleSwelling
        44 -> QuestionSymptom Symptom.IntermittentClaudication
        45 -> QuestionSymptom Symptom.Orthopnoea
        46 -> QuestionSymptom Symptom.Pnd
        47 -> QuestionSymptom Symptom.Loc
        48 -> QuestionSymptom Symptom.Seizure
        49 -> QuestionSymptom Symptom.Fatigue
        50 -> QuestionSymptom Symptom.Haemoptysis
        51 -> QuestionSymptom Symptom.Sputum
        52 -> QuestionSymptom Symptom.SoreThroat
        53 -> QuestionSymptom Symptom.Diaphoresis
        54 -> QuestionSymptom Symptom.JawClaudication
        55 -> QuestionSymptom Symptom.VIsualChange
        56 -> QuestionRashFeature RashFeature.Where
        57 -> QuestionExamine Examine.Rash
        58 -> QuestionExamine Examine.Hands
        59 -> QuestionExamine Examine.General
        60 -> QuestionExamine Examine.Vitals
        61 -> QuestionExamine Examine.Weight
        62 -> QuestionExamine Examine.Surroundings
        63 -> QuestionExamine Examine.Nails
        64 -> QuestionExamine Examine.Arms
        65 -> QuestionExamine Examine.EyeMovements
        66 -> QuestionExamine Examine.VisualFields
        67 -> QuestionExamine Examine.HandMovements
        68 -> QuestionExamine Examine.Fundus
        69 -> QuestionExamine Examine.Snellen
        70 -> QuestionExamine Examine.Pupils
        71 -> QuestionExamine Examine.FacialExpression
        72 -> QuestionExamine Examine.Mastication
        73 -> QuestionExamine Examine.Tongue
        74 -> QuestionExamine Examine.OralMucosa
        75 -> QuestionExamine Examine.HeartAuscultate
        76 -> QuestionExamine Examine.LungsAuscultate
        77 -> QuestionExamine Examine.LungsPercussion
        78 -> QuestionExamine Examine.Chest
        79 -> QuestionExamine Examine.Neck
        80 -> QuestionExamine Examine.PowerArms
        81 -> QuestionExamine Examine.PowerLegs
        82 -> QuestionExamine Examine.SensationArms
        83 -> QuestionExamine Examine.SensationLegs
        84 -> QuestionExamine Examine.MentalState
        85 -> QuestionLocFeature LocFeature.When
        86 -> QuestionSeizureFeature SeizureFeature.Before
        87 -> QuestionSputumFeature SputumFeature.Volume
        88 -> QuestionSputumFeature SputumFeature.Colour
        89 -> QuestionPhx Phx.Hypertension
        90 -> QuestionPhx Phx.Diabetes
        91 -> QuestionPhx Phx.Surgery
        92 -> QuestionPhx Phx.Immunisation
        93 -> QuestionDrugs Drugs.Regular
        94 -> QuestionDrugs Drugs.Otc
        95 -> QuestionDrugs Drugs.Recreational
        96 -> QuestionDrugs Drugs.Allergies
        97 -> QuestionAlcohol Alcohol.YesNo
        98 -> QuestionAlcohol Alcohol.Quantity
        99 -> QuestionSmoke Smoke.YesNo
        100 -> QuestionSmoke Smoke.Duration
        101 -> QuestionSmoke Smoke.History
        102 -> QuestionSmoke Smoke.Quantity
        103 -> QuestionFhx Fhx.ParentHealth
        104 -> QuestionFhx Fhx.Children
        105 -> QuestionFhx Fhx.ChildrenHealth
        106 -> QuestionFhx Fhx.Siblings
        107 -> QuestionFhx Fhx.SiblingsHealth
        108 -> QuestionShx Shx.LivingPlace
        109 -> QuestionShx Shx.LivingPeople
        110 -> QuestionShx Shx.Mood
        111 -> QuestionShx Shx.Diet
        112 -> QuestionShx Shx.PhysicalExercise
        113 -> QuestionShx Shx.Driving
        114 -> QuestionSign Sign.Brudzinski
        115 -> QuestionSign Sign.Papilloedema
        116 -> QuestionSign Sign.Kernig
        117 -> QuestionSign Sign.PeripheralCyanosis
        118 -> QuestionSign Sign.CentralCyanosis
        119 -> QuestionSign Sign.CarotidBruits
        120 -> QuestionSign Sign.Dysdiado
        121 -> QuestionSign Sign.IntentionTremo
        _ -> QuestionDetails Details.Name

toInt : Question -> Int
toInt enum = 
    case enum of 
        QuestionDetails Details.Name -> 0
        QuestionDetails Details.Age -> 1
        QuestionDetails Details.OccupationBrief -> 2
        QuestionDetails Details.OccupationDescription -> 3
        QuestionOpen Open.Opening -> 4
        QuestionOpen Open.Symptoms -> 5
        QuestionOpen Open.Phx -> 6
        QuestionOpen Open.Fhx -> 7
        QuestionPainFeature PainFeature.Where -> 8
        QuestionPainFeature PainFeature.Side -> 9
        QuestionPainFeature PainFeature.Onset -> 10
        QuestionPainFeature PainFeature.Timing -> 11
        QuestionPainFeature PainFeature.Quality -> 12
        QuestionPainFeature PainFeature.Quantity -> 13
        QuestionPainFeature PainFeature.Before -> 14
        QuestionPainFeature PainFeature.Triggers -> 15
        QuestionPainFeature PainFeature.Radiation -> 16
        QuestionSymptomFeature SymptomFeature.When -> 17
        QuestionSymptomFeature SymptomFeature.Quantity -> 18
        QuestionSymptomFeature SymptomFeature.Alleviating -> 19
        QuestionSymptomFeature SymptomFeature.Aggravating -> 20
        QuestionFeelings Feelings.Beliefs -> 21
        QuestionFeelings Feelings.Impact -> 22
        QuestionFeelings Feelings.Expectations -> 23
        QuestionFeelings Feelings.Concerns -> 24
        QuestionSymptom Symptom.Pain -> 25
        QuestionSymptom Symptom.Nausea -> 26
        QuestionSymptom Symptom.Vomiting -> 27
        QuestionSymptom Symptom.NeckStiff -> 28
        QuestionSymptom Symptom.Diplopia -> 29
        QuestionSymptom Symptom.VisualChange -> 30
        QuestionSymptom Symptom.Photophobia -> 31
        QuestionSymptom Symptom.Rhinorrhoea -> 32
        QuestionSymptom Symptom.Cough -> 33
        QuestionSymptom Symptom.Headache -> 34
        QuestionSymptom Symptom.Lacrimation -> 35
        QuestionSymptom Symptom.RecentlyIll -> 36
        QuestionSymptom Symptom.SickContact -> 37
        QuestionSymptom Symptom.Fever -> 38
        QuestionSymptom Symptom.Rash -> 39
        QuestionSymptom Symptom.ChestPain -> 40
        QuestionSymptom Symptom.Dyspnoea -> 41
        QuestionSymptom Symptom.Palpitations -> 42
        QuestionSymptom Symptom.AnkleSwelling -> 43
        QuestionSymptom Symptom.IntermittentClaudication -> 44
        QuestionSymptom Symptom.Orthopnoea -> 45
        QuestionSymptom Symptom.Pnd -> 46
        QuestionSymptom Symptom.Loc -> 47
        QuestionSymptom Symptom.Seizure -> 48
        QuestionSymptom Symptom.Fatigue -> 49
        QuestionSymptom Symptom.Haemoptysis -> 50
        QuestionSymptom Symptom.Sputum -> 51
        QuestionSymptom Symptom.SoreThroat -> 52
        QuestionSymptom Symptom.Diaphoresis -> 53
        QuestionSymptom Symptom.JawClaudication -> 54
        QuestionSymptom Symptom.VIsualChange -> 55
        QuestionRashFeature RashFeature.Where -> 56
        QuestionExamine Examine.Rash -> 57
        QuestionExamine Examine.Hands -> 58
        QuestionExamine Examine.General -> 59
        QuestionExamine Examine.Vitals -> 60
        QuestionExamine Examine.Weight -> 61
        QuestionExamine Examine.Surroundings -> 62
        QuestionExamine Examine.Nails -> 63
        QuestionExamine Examine.Arms -> 64
        QuestionExamine Examine.EyeMovements -> 65
        QuestionExamine Examine.VisualFields -> 66
        QuestionExamine Examine.HandMovements -> 67
        QuestionExamine Examine.Fundus -> 68
        QuestionExamine Examine.Snellen -> 69
        QuestionExamine Examine.Pupils -> 70
        QuestionExamine Examine.FacialExpression -> 71
        QuestionExamine Examine.Mastication -> 72
        QuestionExamine Examine.Tongue -> 73
        QuestionExamine Examine.OralMucosa -> 74
        QuestionExamine Examine.HeartAuscultate -> 75
        QuestionExamine Examine.LungsAuscultate -> 76
        QuestionExamine Examine.LungsPercussion -> 77
        QuestionExamine Examine.Chest -> 78
        QuestionExamine Examine.Neck -> 79
        QuestionExamine Examine.PowerArms -> 80
        QuestionExamine Examine.PowerLegs -> 81
        QuestionExamine Examine.SensationArms -> 82
        QuestionExamine Examine.SensationLegs -> 83
        QuestionExamine Examine.MentalState -> 84
        QuestionLocFeature LocFeature.When -> 85
        QuestionSeizureFeature SeizureFeature.Before -> 86
        QuestionSputumFeature SputumFeature.Volume -> 87
        QuestionSputumFeature SputumFeature.Colour -> 88
        QuestionPhx Phx.Hypertension -> 89
        QuestionPhx Phx.Diabetes -> 90
        QuestionPhx Phx.Surgery -> 91
        QuestionPhx Phx.Immunisation -> 92
        QuestionDrugs Drugs.Regular -> 93
        QuestionDrugs Drugs.Otc -> 94
        QuestionDrugs Drugs.Recreational -> 95
        QuestionDrugs Drugs.Allergies -> 96
        QuestionAlcohol Alcohol.YesNo -> 97
        QuestionAlcohol Alcohol.Quantity -> 98
        QuestionSmoke Smoke.YesNo -> 99
        QuestionSmoke Smoke.Duration -> 100
        QuestionSmoke Smoke.History -> 101
        QuestionSmoke Smoke.Quantity -> 102
        QuestionFhx Fhx.ParentHealth -> 103
        QuestionFhx Fhx.Children -> 104
        QuestionFhx Fhx.ChildrenHealth -> 105
        QuestionFhx Fhx.Siblings -> 106
        QuestionFhx Fhx.SiblingsHealth -> 107
        QuestionShx Shx.LivingPlace -> 108
        QuestionShx Shx.LivingPeople -> 109
        QuestionShx Shx.Mood -> 110
        QuestionShx Shx.Diet -> 111
        QuestionShx Shx.PhysicalExercise -> 112
        QuestionShx Shx.Driving -> 113
        QuestionSign Sign.Brudzinski -> 114
        QuestionSign Sign.Papilloedema -> 115
        QuestionSign Sign.Kernig -> 116
        QuestionSign Sign.PeripheralCyanosis -> 117
        QuestionSign Sign.CentralCyanosis -> 118
        QuestionSign Sign.CarotidBruits -> 119
        QuestionSign Sign.Dysdiado -> 120
        QuestionSign Sign.IntentionTremo -> 121

toString : Question -> String
toString enum = 
    case enum of
        QuestionDetails Details.Name -> "Name"
        QuestionDetails Details.Age -> "Age"
        QuestionDetails Details.OccupationBrief -> "Age"
        QuestionDetails Details.OccupationDescription -> "OccupationBrief"
        QuestionOpen Open.Opening -> "OccupationDescription"
        QuestionOpen Open.Symptoms -> "Opening"
        QuestionOpen Open.Phx -> "Opening"
        QuestionOpen Open.Fhx -> "Opening"
        QuestionPainFeature PainFeature.Where -> "Symptoms"
        QuestionPainFeature PainFeature.Side -> "Phx"
        QuestionPainFeature PainFeature.Onset -> "Fhx"
        QuestionPainFeature PainFeature.Timing -> "Where"
        QuestionPainFeature PainFeature.Quality -> "Side"
        QuestionPainFeature PainFeature.Quantity -> "Onset"
        QuestionPainFeature PainFeature.Before -> "Timing"
        QuestionPainFeature PainFeature.Triggers -> "Quality"
        QuestionPainFeature PainFeature.Radiation -> "Quantity"
        QuestionSymptomFeature SymptomFeature.When -> "Before"
        QuestionSymptomFeature SymptomFeature.Quantity -> "Triggers"
        QuestionSymptomFeature SymptomFeature.Alleviating -> "Radiation"
        QuestionSymptomFeature SymptomFeature.Aggravating -> "When"
        QuestionFeelings Feelings.Beliefs -> "Quantity"
        QuestionFeelings Feelings.Impact -> "Alleviating"
        QuestionFeelings Feelings.Expectations -> "Aggravating"
        QuestionFeelings Feelings.Concerns -> "Beliefs"
        QuestionSymptom Symptom.Pain -> "Impact"
        QuestionSymptom Symptom.Nausea -> "Expectations"
        QuestionSymptom Symptom.Vomiting -> "Concerns"
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
        QuestionSymptom Symptom.Fever -> "Lacrimation"
        QuestionSymptom Symptom.Rash -> "RecentlyIll"
        QuestionSymptom Symptom.ChestPain -> "SickContact"
        QuestionSymptom Symptom.Dyspnoea -> "SickContact"
        QuestionSymptom Symptom.Palpitations -> "Fever"
        QuestionSymptom Symptom.AnkleSwelling -> "Rash"
        QuestionSymptom Symptom.IntermittentClaudication -> "ChestPain"
        QuestionSymptom Symptom.Orthopnoea -> "Dyspnoea"
        QuestionSymptom Symptom.Pnd -> "Palpitations"
        QuestionSymptom Symptom.Loc -> "AnkleSwelling"
        QuestionSymptom Symptom.Seizure -> "IntermittentClaudication"
        QuestionSymptom Symptom.Fatigue -> "Orthopnoea"
        QuestionSymptom Symptom.Haemoptysis -> "Pnd"
        QuestionSymptom Symptom.Sputum -> "Loc"
        QuestionSymptom Symptom.SoreThroat -> "Loc"
        QuestionSymptom Symptom.Diaphoresis -> "Seizure"
        QuestionSymptom Symptom.JawClaudication -> "Fatigue"
        QuestionSymptom Symptom.VIsualChange -> "Fatigue"
        QuestionRashFeature RashFeature.Where -> "Haemoptysis"
        QuestionExamine Examine.Rash -> "Sputum"
        QuestionExamine Examine.Hands -> "SoreThroat"
        QuestionExamine Examine.General -> "Diaphoresis"
        QuestionExamine Examine.Vitals -> "JawClaudication"
        QuestionExamine Examine.Weight -> "VIsualChange"
        QuestionExamine Examine.Surroundings -> "Where"
        QuestionExamine Examine.Nails -> "Rash"
        QuestionExamine Examine.Arms -> "Hands"
        QuestionExamine Examine.EyeMovements -> "General"
        QuestionExamine Examine.VisualFields -> "Vitals"
        QuestionExamine Examine.HandMovements -> "Weight"
        QuestionExamine Examine.Fundus -> "Surroundings"
        QuestionExamine Examine.Snellen -> "Nails"
        QuestionExamine Examine.Pupils -> "Arms"
        QuestionExamine Examine.FacialExpression -> "EyeMovements"
        QuestionExamine Examine.Mastication -> "VisualFields"
        QuestionExamine Examine.Tongue -> "HandMovements"
        QuestionExamine Examine.OralMucosa -> "Fundus"
        QuestionExamine Examine.HeartAuscultate -> "Snellen"
        QuestionExamine Examine.LungsAuscultate -> "Pupils"
        QuestionExamine Examine.LungsPercussion -> "FacialExpression"
        QuestionExamine Examine.Chest -> "Mastication"
        QuestionExamine Examine.Neck -> "Tongue"
        QuestionExamine Examine.PowerArms -> "OralMucosa"
        QuestionExamine Examine.PowerLegs -> "HeartAuscultate"
        QuestionExamine Examine.SensationArms -> "LungsAuscultate"
        QuestionExamine Examine.SensationLegs -> "LungsPercussion"
        QuestionExamine Examine.MentalState -> "Chest"
        QuestionLocFeature LocFeature.When -> "Neck"
        QuestionSeizureFeature SeizureFeature.Before -> "PowerArms"
        QuestionSputumFeature SputumFeature.Volume -> "PowerLegs"
        QuestionSputumFeature SputumFeature.Colour -> "SensationArms"
        QuestionPhx Phx.Hypertension -> "SensationLegs"
        QuestionPhx Phx.Diabetes -> "MentalState"
        QuestionPhx Phx.Surgery -> "When"
        QuestionPhx Phx.Immunisation -> "Before"
        QuestionDrugs Drugs.Regular -> "Volume"
        QuestionDrugs Drugs.Otc -> "Colour"
        QuestionDrugs Drugs.Recreational -> "Hypertension"
        QuestionDrugs Drugs.Allergies -> "Diabetes"
        QuestionAlcohol Alcohol.YesNo -> "Surgery"
        QuestionAlcohol Alcohol.Quantity -> "Immunisation"
        QuestionSmoke Smoke.YesNo -> "Regular"
        QuestionSmoke Smoke.Duration -> "Otc"
        QuestionSmoke Smoke.History -> "Recreational"
        QuestionSmoke Smoke.Quantity -> "Allergies"
        QuestionFhx Fhx.ParentHealth -> "YesNo"
        QuestionFhx Fhx.Children -> "Quantity"
        QuestionFhx Fhx.ChildrenHealth -> "YesNo"
        QuestionFhx Fhx.Siblings -> "Duration"
        QuestionFhx Fhx.SiblingsHealth -> "History"
        QuestionShx Shx.LivingPlace -> "Quantity"
        QuestionShx Shx.LivingPeople -> "ParentHealth"
        QuestionShx Shx.Mood -> "Children"
        QuestionShx Shx.Diet -> "ChildrenHealth"
        QuestionShx Shx.PhysicalExercise -> "Siblings"
        QuestionShx Shx.Driving -> "SiblingsHealth"
        QuestionSign Sign.Brudzinski -> "LivingPlace"
        QuestionSign Sign.Papilloedema -> "LivingPeople"
        QuestionSign Sign.Kernig -> "LivingPeople"
        QuestionSign Sign.PeripheralCyanosis -> "Mood"
        QuestionSign Sign.CentralCyanosis -> "Diet"
        QuestionSign Sign.CarotidBruits -> "PhysicalExercise"
        QuestionSign Sign.Dysdiado -> "Driving"
        QuestionSign Sign.IntentionTremo -> "Brudzinski"

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
    , QuestionSign Sign.IntentionTremo ]

optionList : (Question -> String -> msg) -> List (Option.Data Question msg)
optionList msg =
    [ { value = QuestionDetails Details.Name, string = "What is your name?", onClick = msg (QuestionDetails Details.Name) "What is your name?", tags = "name" }
    , { value = QuestionDetails Details.Age, string = "How old are you?", onClick = msg (QuestionDetails Details.Age) "How old are you?", tags = "nan" }
    , { value = QuestionDetails Details.Age, string = "When were you born?", onClick = msg (QuestionDetails Details.Age) "When were you born?", tags = "date of birth dob" }
    , { value = QuestionDetails Details.OccupationBrief, string = "Do you work?", onClick = msg (QuestionDetails Details.OccupationBrief) "Do you work?", tags = "employed job" }
    , { value = QuestionDetails Details.OccupationDescription, string = "What do you work as?", onClick = msg (QuestionDetails Details.OccupationDescription) "What do you work as?", tags = "job" }
    , { value = QuestionOpen Open.Opening, string = "What's brought you in today?", onClick = msg (QuestionOpen Open.Opening) "What's brought you in today?", tags = "nan" }
    , { value = QuestionOpen Open.Opening, string = "Why have you come to see us today?", onClick = msg (QuestionOpen Open.Opening) "Why have you come to see us today?", tags = "nan" }
    , { value = QuestionOpen Open.Opening, string = "How can I help you today?", onClick = msg (QuestionOpen Open.Opening) "How can I help you today?", tags = "nan" }
    , { value = QuestionPainFeature PainFeature.Where, string = "Where is the pain?", onClick = msg (QuestionPainFeature PainFeature.Where) "Where is the pain?", tags = "location site" }
    , { value = QuestionPainFeature PainFeature.Side, string = "Which side do you feel the pain on?", onClick = msg (QuestionPainFeature PainFeature.Side) "Which side do you feel the pain on?", tags = "unilateral bilateral " }
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
    , { value = QuestionSymptom Symptom.Palpitations, string = "Do you feel like your heartbeat is abnormal?", onClick = msg (QuestionSymptom Symptom.Palpitations) "Do you feel like your heartbeat is abnormal?", tags = "nan" }
    , { value = QuestionSymptom Symptom.AnkleSwelling, string = "Have your ankles been swollen?", onClick = msg (QuestionSymptom Symptom.AnkleSwelling) "Have your ankles been swollen?", tags = "nan" }
    , { value = QuestionSymptom Symptom.IntermittentClaudication, string = "Do you have pain in your legs when you walk?", onClick = msg (QuestionSymptom Symptom.IntermittentClaudication) "Do you have pain in your legs when you walk?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Orthopnoea, string = "Do you feel short of breath when you lie down?", onClick = msg (QuestionSymptom Symptom.Orthopnoea) "Do you feel short of breath when you lie down?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Pnd, string = "Do you wake up at night gasping for breath?", onClick = msg (QuestionSymptom Symptom.Pnd) "Do you wake up at night gasping for breath?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Loc, string = "Have you fainted?", onClick = msg (QuestionSymptom Symptom.Loc) "Have you fainted?", tags = "nan" }
    , { value = QuestionSymptom Symptom.Loc, string = "Have you lost consciousness?", onClick = msg (QuestionSymptom Symptom.Loc) "Have you lost consciousness?", tags = "nan" }
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
    , { value = QuestionPhx Phx.Surgery, string = "Have you had any surgeries in the past?", onClick = msg (QuestionPhx Phx.Surgery) "Have you had any surgeries in the past?", tags = "nan" }
    , { value = QuestionPhx Phx.Immunisation, string = "Are your immunisations up to date?", onClick = msg (QuestionPhx Phx.Immunisation) "Are your immunisations up to date?", tags = "nan" }
    , { value = QuestionDrugs Drugs.Regular, string = "Are you taking any regular medications?", onClick = msg (QuestionDrugs Drugs.Regular) "Are you taking any regular medications?", tags = "nan" }
    , { value = QuestionDrugs Drugs.Otc, string = "Are you taking any over the counter medications?", onClick = msg (QuestionDrugs Drugs.Otc) "Are you taking any over the counter medications?", tags = "nan" }
    , { value = QuestionDrugs Drugs.Recreational, string = "Do you use any recreational drugs?", onClick = msg (QuestionDrugs Drugs.Recreational) "Do you use any recreational drugs?", tags = "nan" }
    , { value = QuestionDrugs Drugs.Allergies, string = "Do you have any allergies, and what reactions do you get?", onClick = msg (QuestionDrugs Drugs.Allergies) "Do you have any allergies, and what reactions do you get?", tags = "nan" }
    , { value = QuestionAlcohol Alcohol.YesNo, string = "Do you drink alcohol?", onClick = msg (QuestionAlcohol Alcohol.YesNo) "Do you drink alcohol?", tags = "nan" }
    , { value = QuestionAlcohol Alcohol.Quantity, string = "How much alcohol do you drink?", onClick = msg (QuestionAlcohol Alcohol.Quantity) "How much alcohol do you drink?", tags = "nan" }
    , { value = QuestionSmoke Smoke.YesNo, string = "Do you smoke?", onClick = msg (QuestionSmoke Smoke.YesNo) "Do you smoke?", tags = "nan" }
    , { value = QuestionSmoke Smoke.Duration, string = "How long have you smoked for?", onClick = msg (QuestionSmoke Smoke.Duration) "How long have you smoked for?", tags = "nan" }
    , { value = QuestionSmoke Smoke.History, string = "Have you ever smoked?", onClick = msg (QuestionSmoke Smoke.History) "Have you ever smoked?", tags = "nan" }
    , { value = QuestionSmoke Smoke.Quantity, string = "How many cigarettes a day do you or did you smoke?", onClick = msg (QuestionSmoke Smoke.Quantity) "How many cigarettes a day do you or did you smoke?", tags = "nan" }
    , { value = QuestionOpen Open.Fhx, string = "Do any conditions run through the family?", onClick = msg (QuestionOpen Open.Fhx) "Do any conditions run through the family?", tags = "nan" }
    , { value = QuestionFhx Fhx.ParentHealth, string = "How are your parents' health?", onClick = msg (QuestionFhx Fhx.ParentHealth) "How are your parents' health?", tags = "nan" }
    , { value = QuestionFhx Fhx.Children, string = "Do you have any children?", onClick = msg (QuestionFhx Fhx.Children) "Do you have any children?", tags = "nan" }
    , { value = QuestionFhx Fhx.ChildrenHealth, string = "How are your children's health?", onClick = msg (QuestionFhx Fhx.ChildrenHealth) "How are your children's health?", tags = "nan" }
    , { value = QuestionFhx Fhx.Siblings, string = "Do you have any siblings?", onClick = msg (QuestionFhx Fhx.Siblings) "Do you have any siblings?", tags = "nan" }
    , { value = QuestionFhx Fhx.SiblingsHealth, string = "How are your siblings' health?", onClick = msg (QuestionFhx Fhx.SiblingsHealth) "How are your siblings' health?", tags = "nan" }
    , { value = QuestionShx Shx.LivingPlace, string = "Where do you live at the moment?", onClick = msg (QuestionShx Shx.LivingPlace) "Where do you live at the moment?", tags = "nan" }
    , { value = QuestionShx Shx.LivingPeople, string = "Who do you live with at the moment?", onClick = msg (QuestionShx Shx.LivingPeople) "Who do you live with at the moment?", tags = "nan" }
    , { value = QuestionShx Shx.LivingPeople, string = "Do you live by yourself?", onClick = msg (QuestionShx Shx.LivingPeople) "Do you live by yourself?", tags = "nan" }
    , { value = QuestionShx Shx.Mood, string = "How is your mood?", onClick = msg (QuestionShx Shx.Mood) "How is your mood?", tags = "nan" }
    , { value = QuestionShx Shx.Diet, string = "What are do you usually eat day to day?", onClick = msg (QuestionShx Shx.Diet) "What are do you usually eat day to day?", tags = "nan" }
    , { value = QuestionShx Shx.PhysicalExercise, string = "Do you do physical exercise?", onClick = msg (QuestionShx Shx.PhysicalExercise) "Do you do physical exercise?", tags = "nan" }
    , { value = QuestionShx Shx.Driving, string = "Do you drive?", onClick = msg (QuestionShx Shx.Driving) "Do you drive?", tags = "nan" }
    , { value = QuestionExamine Examine.Hands, string = "Examine the hands. ", onClick = msg (QuestionExamine Examine.Hands) "Examine the hands. ", tags = "nan" }
    , { value = QuestionExamine Examine.General, string = "Examine with general inspection.", onClick = msg (QuestionExamine Examine.General) "Examine with general inspection.", tags = "nan" }
    , { value = QuestionExamine Examine.Vitals, string = "Examine the vital signs.", onClick = msg (QuestionExamine Examine.Vitals) "Examine the vital signs.", tags = "nan" }
    , { value = QuestionExamine Examine.Weight, string = "Examine weight.", onClick = msg (QuestionExamine Examine.Weight) "Examine weight.", tags = "nan" }
    , { value = QuestionExamine Examine.Surroundings, string = "Examine the surroundings.", onClick = msg (QuestionExamine Examine.Surroundings) "Examine the surroundings.", tags = "nan" }
    , { value = QuestionExamine Examine.Nails, string = "Examine the nails.", onClick = msg (QuestionExamine Examine.Nails) "Examine the nails.", tags = "nan" }
    , { value = QuestionExamine Examine.Arms, string = "Examine the arms.", onClick = msg (QuestionExamine Examine.Arms) "Examine the arms.", tags = "nan" }
    , { value = QuestionExamine Examine.EyeMovements, string = "Examine the eye movements.", onClick = msg (QuestionExamine Examine.EyeMovements) "Examine the eye movements.", tags = "nan" }
    , { value = QuestionExamine Examine.VisualFields, string = "Examine the visual fields with a confrontation test.", onClick = msg (QuestionExamine Examine.VisualFields) "Examine the visual fields with a confrontation test.", tags = "nan" }
    , { value = QuestionExamine Examine.HandMovements, string = "Examine hand movements.", onClick = msg (QuestionExamine Examine.HandMovements) "Examine hand movements.", tags = "nan" }
    , { value = QuestionExamine Examine.Fundus, string = "Examine the fundus with an ophthalmoscope.", onClick = msg (QuestionExamine Examine.Fundus) "Examine the fundus with an ophthalmoscope.", tags = "nan" }
    , { value = QuestionExamine Examine.Snellen, string = "Examine visual acuity with a Snellen chart.", onClick = msg (QuestionExamine Examine.Snellen) "Examine visual acuity with a Snellen chart.", tags = "nan" }
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
    , { value = QuestionExamine Examine.Chest, string = "Examine the chest.", onClick = msg (QuestionExamine Examine.Chest) "Examine the chest.", tags = "nan" }
    , { value = QuestionExamine Examine.Neck, string = "Examine the neck.", onClick = msg (QuestionExamine Examine.Neck) "Examine the neck.", tags = "nan" }
    , { value = QuestionSign Sign.CarotidBruits, string = "Check for carotid bruits.", onClick = msg (QuestionSign Sign.CarotidBruits) "Check for carotid bruits.", tags = "nan" }
    , { value = QuestionExamine Examine.PowerArms, string = "Examine the power of the arms.", onClick = msg (QuestionExamine Examine.PowerArms) "Examine the power of the arms.", tags = "nan" }
    , { value = QuestionExamine Examine.PowerLegs, string = "Examine the power of the legs.", onClick = msg (QuestionExamine Examine.PowerLegs) "Examine the power of the legs.", tags = "nan" }
    , { value = QuestionExamine Examine.SensationArms, string = "Examine the sensation over the arms.", onClick = msg (QuestionExamine Examine.SensationArms) "Examine the sensation over the arms.", tags = "nan" }
    , { value = QuestionExamine Examine.SensationLegs, string = "Examine the sensation over the legs.", onClick = msg (QuestionExamine Examine.SensationLegs) "Examine the sensation over the legs.", tags = "nan" }
    , { value = QuestionSign Sign.Dysdiado, string = "Check for dysdiadochokinesia.", onClick = msg (QuestionSign Sign.Dysdiado) "Check for dysdiadochokinesia.", tags = "nan" }
    , { value = QuestionSign Sign.IntentionTremo, string = "Check for intention tremor.", onClick = msg (QuestionSign Sign.IntentionTremo) "Check for intention tremor.", tags = "nan" }
    , { value = QuestionExamine Examine.MentalState, string = "Examine the mental state of the patient.", onClick = msg (QuestionExamine Examine.MentalState) "Examine the mental state of the patient.", tags = "nan" } ]

