module Investigations.Investigation exposing (..)

import Investigations.Bloods as Bloods exposing (..)
import Investigations.Imaging as Imaging exposing (..)
import Investigations.Other as Other exposing (..)
import Option


type Investigation
    = InvestigationBloods Bloods
    | InvestigationImaging Imaging
    | InvestigationOther Other


fromInt : Int -> Investigation
fromInt int =
    case int of
        0 ->
            InvestigationBloods FBE

        1 ->
            InvestigationBloods UEC

        2 ->
            InvestigationBloods LFT

        3 ->
            InvestigationBloods Troponin

        4 ->
            InvestigationBloods CMP

        5 ->
            InvestigationBloods CRP

        6 ->
            InvestigationBloods Amylase

        7 ->
            InvestigationBloods ANA

        8 ->
            InvestigationBloods Bilirubin

        9 ->
            InvestigationBloods CK

        10 ->
            InvestigationBloods ESR

        11 ->
            InvestigationBloods FBG

        12 ->
            InvestigationBloods Ironstudies

        13 ->
            InvestigationBloods Lactate

        14 ->
            InvestigationBloods LDH

        15 ->
            InvestigationBloods Lipids

        16 ->
            InvestigationBloods TFT

        17 ->
            InvestigationImaging CXR

        18 ->
            InvestigationImaging AXR

        19 ->
            InvestigationImaging CTBrain

        20 ->
            InvestigationImaging MRIBrain

        21 ->
            InvestigationImaging CTAbdoPelvis

        22 ->
            InvestigationOther ECG

        23 ->
            InvestigationOther Spirometry

        24 ->
            InvestigationOther Echocardiogram

        25 ->
            InvestigationOther EEG

        _ ->
            InvestigationBloods FBE


toInt : Investigation -> Int
toInt enum =
    case enum of
        InvestigationBloods FBE ->
            0

        InvestigationBloods UEC ->
            1

        InvestigationBloods LFT ->
            2

        InvestigationBloods Troponin ->
            3

        InvestigationBloods CMP ->
            4

        InvestigationBloods CRP ->
            5

        InvestigationBloods Amylase ->
            6

        InvestigationBloods ANA ->
            7

        InvestigationBloods Bilirubin ->
            8

        InvestigationBloods CK ->
            9

        InvestigationBloods ESR ->
            10

        InvestigationBloods FBG ->
            11

        InvestigationBloods Ironstudies ->
            12

        InvestigationBloods Lactate ->
            13

        InvestigationBloods LDH ->
            14

        InvestigationBloods Lipids ->
            15

        InvestigationBloods TFT ->
            16

        InvestigationImaging CXR ->
            17

        InvestigationImaging AXR ->
            18

        InvestigationImaging CTBrain ->
            19

        InvestigationImaging MRIBrain ->
            20

        InvestigationImaging CTAbdoPelvis ->
            21

        InvestigationOther ECG ->
            22

        InvestigationOther Spirometry ->
            23

        InvestigationOther Echocardiogram ->
            24

        InvestigationOther EEG ->
            25


toString : Investigation -> String
toString enum =
    case enum of
        InvestigationBloods FBE ->
            "FBE"

        InvestigationBloods UEC ->
            "UEC"

        InvestigationBloods LFT ->
            "LFT"

        InvestigationBloods Troponin ->
            "Troponin"

        InvestigationBloods CMP ->
            "CMP"

        InvestigationBloods CRP ->
            "CRP"

        InvestigationBloods Amylase ->
            "Amylase"

        InvestigationBloods ANA ->
            "ANA"

        InvestigationBloods Bilirubin ->
            "Bilirubin"

        InvestigationBloods CK ->
            "CK"

        InvestigationBloods ESR ->
            "ESR"

        InvestigationBloods FBG ->
            "FBG"

        InvestigationBloods Ironstudies ->
            "Iron studies"

        InvestigationBloods Lactate ->
            "Lactate"

        InvestigationBloods LDH ->
            "LDH"

        InvestigationBloods Lipids ->
            "Lipids"

        InvestigationBloods TFT ->
            "TFT"

        InvestigationImaging CXR ->
            "CXR"

        InvestigationImaging AXR ->
            "AXR"

        InvestigationImaging CTBrain ->
            "CT Brain"

        InvestigationImaging MRIBrain ->
            "MRI Brain"

        InvestigationImaging CTAbdoPelvis ->
            "CT Abdo Pelvis"

        InvestigationOther ECG ->
            "ECG"

        InvestigationOther Spirometry ->
            "Spirometry"

        InvestigationOther Echocardiogram ->
            "Echocardiogram"

        InvestigationOther EEG ->
            "EEG"


list : List Investigation
list =
    [ InvestigationBloods FBE
    , InvestigationBloods UEC
    , InvestigationBloods LFT
    , InvestigationBloods Troponin
    , InvestigationBloods CMP
    , InvestigationBloods CRP
    , InvestigationBloods Amylase
    , InvestigationBloods ANA
    , InvestigationBloods Bilirubin
    , InvestigationBloods CK
    , InvestigationBloods ESR
    , InvestigationBloods FBG
    , InvestigationBloods Ironstudies
    , InvestigationBloods Lactate
    , InvestigationBloods LDH
    , InvestigationBloods Lipids
    , InvestigationBloods TFT
    , InvestigationImaging CXR
    , InvestigationImaging AXR
    , InvestigationImaging CTBrain
    , InvestigationImaging MRIBrain
    , InvestigationImaging CTAbdoPelvis
    , InvestigationOther ECG
    , InvestigationOther Spirometry
    , InvestigationOther Echocardiogram
    , InvestigationOther EEG
    ]


optionList : (Investigation -> msg) -> List (Option.Data Investigation msg)
optionList msg =
    [ { value = InvestigationBloods FBE, string = "FBE", onClick = msg, tags = "" }
    , { value = InvestigationBloods UEC, string = "UEC", onClick = msg, tags = "" }
    , { value = InvestigationBloods LFT, string = "LFT", onClick = msg, tags = "" }
    , { value = InvestigationBloods Troponin, string = "Troponin", onClick = msg, tags = "" }
    , { value = InvestigationBloods CMP, string = "CMP", onClick = msg, tags = "" }
    , { value = InvestigationBloods CRP, string = "CRP", onClick = msg, tags = "" }
    , { value = InvestigationBloods Amylase, string = "Amylase", onClick = msg, tags = "" }
    , { value = InvestigationBloods ANA, string = "ANA", onClick = msg, tags = "" }
    , { value = InvestigationBloods Bilirubin, string = "Bilirubin", onClick = msg, tags = "" }
    , { value = InvestigationBloods CK, string = "CK", onClick = msg, tags = "" }
    , { value = InvestigationBloods ESR, string = "ESR", onClick = msg, tags = "" }
    , { value = InvestigationBloods FBG, string = "FBG", onClick = msg, tags = "" }
    , { value = InvestigationBloods Ironstudies, string = "Iron studies", onClick = msg, tags = "" }
    , { value = InvestigationBloods Lactate, string = "Lactate", onClick = msg, tags = "" }
    , { value = InvestigationBloods LDH, string = "LDH", onClick = msg, tags = "" }
    , { value = InvestigationBloods Lipids, string = "Lipids", onClick = msg, tags = "" }
    , { value = InvestigationBloods TFT, string = "TFT", onClick = msg, tags = "" }
    , { value = InvestigationImaging CXR, string = "CXR", onClick = msg, tags = "" }
    , { value = InvestigationImaging AXR, string = "AXR", onClick = msg, tags = "" }
    , { value = InvestigationImaging CTBrain, string = "CT Brain", onClick = msg, tags = "" }
    , { value = InvestigationImaging MRIBrain, string = "MRI Brain", onClick = msg, tags = "" }
    , { value = InvestigationImaging CTAbdoPelvis, string = "CT Abdo Pelvis", onClick = msg, tags = "" }
    , { value = InvestigationOther ECG, string = "ECG", onClick = msg, tags = "" }
    , { value = InvestigationOther Spirometry, string = "Spirometry", onClick = msg, tags = "" }
    , { value = InvestigationOther Echocardiogram, string = "Echocardiogram", onClick = msg, tags = "" }
    , { value = InvestigationOther EEG, string = "EEG", onClick = msg, tags = "" }
    ]
