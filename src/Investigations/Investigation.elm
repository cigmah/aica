module Investigations.Investigation exposing (..)

import Option
import Array exposing (Array)

import Investigations.Bloods as Bloods exposing (..)
import Investigations.Imaging as Imaging exposing (..)
import Investigations.Other as Other exposing (..)

type Investigation = InvestigationBloods Bloods
    | InvestigationImaging Imaging
    | InvestigationOther Other

fromInt : Int -> Investigation
fromInt int = 
    case int of
        0 -> InvestigationBloods Bloods.FBE
        1 -> InvestigationBloods Bloods.UEC
        2 -> InvestigationBloods Bloods.LFT
        3 -> InvestigationBloods Bloods.Troponin
        4 -> InvestigationBloods Bloods.CMP
        5 -> InvestigationBloods Bloods.CRP
        6 -> InvestigationBloods Bloods.Amylase
        7 -> InvestigationBloods Bloods.ANA
        8 -> InvestigationBloods Bloods.Bilirubin
        9 -> InvestigationBloods Bloods.CK
        10 -> InvestigationBloods Bloods.ESR
        11 -> InvestigationBloods Bloods.FBG
        12 -> InvestigationBloods Bloods.Ironstudies
        13 -> InvestigationBloods Bloods.Lactate
        14 -> InvestigationBloods Bloods.LDH
        15 -> InvestigationBloods Bloods.Lipids
        16 -> InvestigationBloods Bloods.TFT
        17 -> InvestigationImaging Imaging.CXR
        18 -> InvestigationImaging Imaging.AXR
        19 -> InvestigationImaging Imaging.CTBrain
        20 -> InvestigationImaging Imaging.MRIBrain
        21 -> InvestigationImaging Imaging.CTAbdoPelvis
        22 -> InvestigationOther Other.ECG
        23 -> InvestigationOther Other.Spirometry
        24 -> InvestigationOther Other.Echocardiogram
        25 -> InvestigationOther Other.EEG
        _ -> InvestigationBloods Bloods.FBE

toInt : Investigation -> Int
toInt enum = 
    case enum of 
        InvestigationBloods Bloods.FBE -> 0
        InvestigationBloods Bloods.UEC -> 1
        InvestigationBloods Bloods.LFT -> 2
        InvestigationBloods Bloods.Troponin -> 3
        InvestigationBloods Bloods.CMP -> 4
        InvestigationBloods Bloods.CRP -> 5
        InvestigationBloods Bloods.Amylase -> 6
        InvestigationBloods Bloods.ANA -> 7
        InvestigationBloods Bloods.Bilirubin -> 8
        InvestigationBloods Bloods.CK -> 9
        InvestigationBloods Bloods.ESR -> 10
        InvestigationBloods Bloods.FBG -> 11
        InvestigationBloods Bloods.Ironstudies -> 12
        InvestigationBloods Bloods.Lactate -> 13
        InvestigationBloods Bloods.LDH -> 14
        InvestigationBloods Bloods.Lipids -> 15
        InvestigationBloods Bloods.TFT -> 16
        InvestigationImaging Imaging.CXR -> 17
        InvestigationImaging Imaging.AXR -> 18
        InvestigationImaging Imaging.CTBrain -> 19
        InvestigationImaging Imaging.MRIBrain -> 20
        InvestigationImaging Imaging.CTAbdoPelvis -> 21
        InvestigationOther Other.ECG -> 22
        InvestigationOther Other.Spirometry -> 23
        InvestigationOther Other.Echocardiogram -> 24
        InvestigationOther Other.EEG -> 25

toString : Investigation -> String
toString enum = 
    case enum of
        InvestigationBloods Bloods.FBE -> "FBE"
        InvestigationBloods Bloods.UEC -> "UEC"
        InvestigationBloods Bloods.LFT -> "LFT"
        InvestigationBloods Bloods.Troponin -> "Troponin"
        InvestigationBloods Bloods.CMP -> "CMP"
        InvestigationBloods Bloods.CRP -> "CRP"
        InvestigationBloods Bloods.Amylase -> "Amylase"
        InvestigationBloods Bloods.ANA -> "ANA"
        InvestigationBloods Bloods.Bilirubin -> "Bilirubin"
        InvestigationBloods Bloods.CK -> "CK"
        InvestigationBloods Bloods.ESR -> "ESR"
        InvestigationBloods Bloods.FBG -> "FBG"
        InvestigationBloods Bloods.Ironstudies -> "Iron studies"
        InvestigationBloods Bloods.Lactate -> "Lactate"
        InvestigationBloods Bloods.LDH -> "LDH"
        InvestigationBloods Bloods.Lipids -> "Lipids"
        InvestigationBloods Bloods.TFT -> "TFT"
        InvestigationImaging Imaging.CXR -> "CXR"
        InvestigationImaging Imaging.AXR -> "AXR"
        InvestigationImaging Imaging.CTBrain -> "CT Brain"
        InvestigationImaging Imaging.MRIBrain -> "MRI Brain"
        InvestigationImaging Imaging.CTAbdoPelvis -> "CT Abdo Pelvis"
        InvestigationOther Other.ECG -> "ECG"
        InvestigationOther Other.Spirometry -> "Spirometry"
        InvestigationOther Other.Echocardiogram -> "Echocardiogram"
        InvestigationOther Other.EEG -> "EEG"

list : List Investigation
list = 
    [ InvestigationBloods Bloods.FBE
    , InvestigationBloods Bloods.UEC
    , InvestigationBloods Bloods.LFT
    , InvestigationBloods Bloods.Troponin
    , InvestigationBloods Bloods.CMP
    , InvestigationBloods Bloods.CRP
    , InvestigationBloods Bloods.Amylase
    , InvestigationBloods Bloods.ANA
    , InvestigationBloods Bloods.Bilirubin
    , InvestigationBloods Bloods.CK
    , InvestigationBloods Bloods.ESR
    , InvestigationBloods Bloods.FBG
    , InvestigationBloods Bloods.Ironstudies
    , InvestigationBloods Bloods.Lactate
    , InvestigationBloods Bloods.LDH
    , InvestigationBloods Bloods.Lipids
    , InvestigationBloods Bloods.TFT
    , InvestigationImaging Imaging.CXR
    , InvestigationImaging Imaging.AXR
    , InvestigationImaging Imaging.CTBrain
    , InvestigationImaging Imaging.MRIBrain
    , InvestigationImaging Imaging.CTAbdoPelvis
    , InvestigationOther Other.ECG
    , InvestigationOther Other.Spirometry
    , InvestigationOther Other.Echocardiogram
    , InvestigationOther Other.EEG ]

optionList : (Investigation -> String -> msg) -> Array (Option.Data Investigation msg)
optionList msg = Array.fromList
    [ { value = InvestigationBloods Bloods.FBE, string = "FBE", onClick = msg (InvestigationBloods Bloods.FBE) "FBE", tags = "" }
    , { value = InvestigationBloods Bloods.UEC, string = "UEC", onClick = msg (InvestigationBloods Bloods.UEC) "UEC", tags = "" }
    , { value = InvestigationBloods Bloods.LFT, string = "LFT", onClick = msg (InvestigationBloods Bloods.LFT) "LFT", tags = "" }
    , { value = InvestigationBloods Bloods.Troponin, string = "Troponin", onClick = msg (InvestigationBloods Bloods.Troponin) "Troponin", tags = "" }
    , { value = InvestigationBloods Bloods.CMP, string = "CMP", onClick = msg (InvestigationBloods Bloods.CMP) "CMP", tags = "" }
    , { value = InvestigationBloods Bloods.CRP, string = "CRP", onClick = msg (InvestigationBloods Bloods.CRP) "CRP", tags = "" }
    , { value = InvestigationBloods Bloods.Amylase, string = "Amylase", onClick = msg (InvestigationBloods Bloods.Amylase) "Amylase", tags = "" }
    , { value = InvestigationBloods Bloods.ANA, string = "ANA", onClick = msg (InvestigationBloods Bloods.ANA) "ANA", tags = "" }
    , { value = InvestigationBloods Bloods.Bilirubin, string = "Bilirubin", onClick = msg (InvestigationBloods Bloods.Bilirubin) "Bilirubin", tags = "" }
    , { value = InvestigationBloods Bloods.CK, string = "CK", onClick = msg (InvestigationBloods Bloods.CK) "CK", tags = "" }
    , { value = InvestigationBloods Bloods.ESR, string = "ESR", onClick = msg (InvestigationBloods Bloods.ESR) "ESR", tags = "" }
    , { value = InvestigationBloods Bloods.FBG, string = "FBG", onClick = msg (InvestigationBloods Bloods.FBG) "FBG", tags = "" }
    , { value = InvestigationBloods Bloods.Ironstudies, string = "Iron studies", onClick = msg (InvestigationBloods Bloods.Ironstudies) "Iron studies", tags = "" }
    , { value = InvestigationBloods Bloods.Lactate, string = "Lactate", onClick = msg (InvestigationBloods Bloods.Lactate) "Lactate", tags = "" }
    , { value = InvestigationBloods Bloods.LDH, string = "LDH", onClick = msg (InvestigationBloods Bloods.LDH) "LDH", tags = "" }
    , { value = InvestigationBloods Bloods.Lipids, string = "Lipids", onClick = msg (InvestigationBloods Bloods.Lipids) "Lipids", tags = "" }
    , { value = InvestigationBloods Bloods.TFT, string = "TFT", onClick = msg (InvestigationBloods Bloods.TFT) "TFT", tags = "" }
    , { value = InvestigationImaging Imaging.CXR, string = "CXR", onClick = msg (InvestigationImaging Imaging.CXR) "CXR", tags = "" }
    , { value = InvestigationImaging Imaging.AXR, string = "AXR", onClick = msg (InvestigationImaging Imaging.AXR) "AXR", tags = "" }
    , { value = InvestigationImaging Imaging.CTBrain, string = "CT Brain", onClick = msg (InvestigationImaging Imaging.CTBrain) "CT Brain", tags = "" }
    , { value = InvestigationImaging Imaging.MRIBrain, string = "MRI Brain", onClick = msg (InvestigationImaging Imaging.MRIBrain) "MRI Brain", tags = "" }
    , { value = InvestigationImaging Imaging.CTAbdoPelvis, string = "CT Abdo Pelvis", onClick = msg (InvestigationImaging Imaging.CTAbdoPelvis) "CT Abdo Pelvis", tags = "" }
    , { value = InvestigationOther Other.ECG, string = "ECG", onClick = msg (InvestigationOther Other.ECG) "ECG", tags = "" }
    , { value = InvestigationOther Other.Spirometry, string = "Spirometry", onClick = msg (InvestigationOther Other.Spirometry) "Spirometry", tags = "" }
    , { value = InvestigationOther Other.Echocardiogram, string = "Echocardiogram", onClick = msg (InvestigationOther Other.Echocardiogram) "Echocardiogram", tags = "" }
    , { value = InvestigationOther Other.EEG, string = "EEG", onClick = msg (InvestigationOther Other.EEG) "EEG", tags = "" } ]

