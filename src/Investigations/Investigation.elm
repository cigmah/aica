module Investigations.Investigation exposing (..)

import Option
import Array exposing (Array)

import Investigations.Bloods as Bloods exposing (..)
import Investigations.Imaging as Imaging exposing (..)
import Investigations.Other as Other exposing (..)
import Investigations.CSF as CSF exposing (..)

type Investigation = InvestigationBloods Bloods
    | InvestigationImaging Imaging
    | InvestigationOther Other
    | InvestigationCSF CSF

fromInt : Int -> Investigation
fromInt int = 
    case int of
        0 -> InvestigationBloods Bloods.FBEFullBloodExamination
        1 -> InvestigationBloods Bloods.UECUreaElectrolytesandCreatinine
        2 -> InvestigationBloods Bloods.LFTLiverFunctionTests
        3 -> InvestigationBloods Bloods.Troponin
        4 -> InvestigationBloods Bloods.CMPCalciumMagnesiumPhosphate
        5 -> InvestigationBloods Bloods.CRPCReactiveProtein
        6 -> InvestigationBloods Bloods.Amylase
        7 -> InvestigationBloods Bloods.ANAAntiNuclearAntibodies
        8 -> InvestigationBloods Bloods.Bilirubin
        9 -> InvestigationBloods Bloods.CKCreatineKinase
        10 -> InvestigationBloods Bloods.ESRErythrocyteSedimentationRate
        11 -> InvestigationBloods Bloods.FBGFastingBloodGlucose
        12 -> InvestigationBloods Bloods.Iron
        13 -> InvestigationBloods Bloods.Lactate
        14 -> InvestigationBloods Bloods.LDHLactateDehydrogenase
        15 -> InvestigationBloods Bloods.Lipids
        16 -> InvestigationBloods Bloods.TFTThyroidFunctionTests
        17 -> InvestigationBloods Bloods.APTTActivatedpartialthromboplastintime
        18 -> InvestigationBloods Bloods.PTProthrombintime
        19 -> InvestigationImaging Imaging.CXRChestXray
        20 -> InvestigationImaging Imaging.AXRAbdominalXray
        21 -> InvestigationImaging Imaging.CTBCTBrain
        22 -> InvestigationImaging Imaging.MRIBrain
        23 -> InvestigationImaging Imaging.CTAbdoPelvis
        24 -> InvestigationOther Other.ECGElectrocardiogram
        25 -> InvestigationOther Other.Spirometry
        26 -> InvestigationOther Other.Echocardiogram
        27 -> InvestigationOther Other.EEGElectroencephalography
        28 -> InvestigationCSF CSF.CSFMCS
        29 -> InvestigationCSF CSF.CSFcytology
        30 -> InvestigationCSF CSF.CSFglucose
        31 -> InvestigationCSF CSF.CSFelectrophoresis
        32 -> InvestigationCSF CSF.CSFcellcount
        _ -> InvestigationBloods Bloods.FBEFullBloodExamination

toInt : Investigation -> Int
toInt enum = 
    case enum of 
        InvestigationBloods Bloods.FBEFullBloodExamination -> 0
        InvestigationBloods Bloods.UECUreaElectrolytesandCreatinine -> 1
        InvestigationBloods Bloods.LFTLiverFunctionTests -> 2
        InvestigationBloods Bloods.Troponin -> 3
        InvestigationBloods Bloods.CMPCalciumMagnesiumPhosphate -> 4
        InvestigationBloods Bloods.CRPCReactiveProtein -> 5
        InvestigationBloods Bloods.Amylase -> 6
        InvestigationBloods Bloods.ANAAntiNuclearAntibodies -> 7
        InvestigationBloods Bloods.Bilirubin -> 8
        InvestigationBloods Bloods.CKCreatineKinase -> 9
        InvestigationBloods Bloods.ESRErythrocyteSedimentationRate -> 10
        InvestigationBloods Bloods.FBGFastingBloodGlucose -> 11
        InvestigationBloods Bloods.Iron -> 12
        InvestigationBloods Bloods.Lactate -> 13
        InvestigationBloods Bloods.LDHLactateDehydrogenase -> 14
        InvestigationBloods Bloods.Lipids -> 15
        InvestigationBloods Bloods.TFTThyroidFunctionTests -> 16
        InvestigationBloods Bloods.APTTActivatedpartialthromboplastintime -> 17
        InvestigationBloods Bloods.PTProthrombintime -> 18
        InvestigationImaging Imaging.CXRChestXray -> 19
        InvestigationImaging Imaging.AXRAbdominalXray -> 20
        InvestigationImaging Imaging.CTBCTBrain -> 21
        InvestigationImaging Imaging.MRIBrain -> 22
        InvestigationImaging Imaging.CTAbdoPelvis -> 23
        InvestigationOther Other.ECGElectrocardiogram -> 24
        InvestigationOther Other.Spirometry -> 25
        InvestigationOther Other.Echocardiogram -> 26
        InvestigationOther Other.EEGElectroencephalography -> 27
        InvestigationCSF CSF.CSFMCS -> 28
        InvestigationCSF CSF.CSFcytology -> 29
        InvestigationCSF CSF.CSFglucose -> 30
        InvestigationCSF CSF.CSFelectrophoresis -> 31
        InvestigationCSF CSF.CSFcellcount -> 32

toString : Investigation -> String
toString enum = 
    case enum of
        InvestigationBloods Bloods.FBEFullBloodExamination -> "FBE (Full Blood Examination)"
        InvestigationBloods Bloods.UECUreaElectrolytesandCreatinine -> "UEC (Urea, Electrolytes and Creatinine)"
        InvestigationBloods Bloods.LFTLiverFunctionTests -> "LFT (Liver Function Tests)"
        InvestigationBloods Bloods.Troponin -> "Troponin"
        InvestigationBloods Bloods.CMPCalciumMagnesiumPhosphate -> "CMP (Calcium Magnesium Phosphate)"
        InvestigationBloods Bloods.CRPCReactiveProtein -> "CRP (C-Reactive Protein)"
        InvestigationBloods Bloods.Amylase -> "Amylase"
        InvestigationBloods Bloods.ANAAntiNuclearAntibodies -> "ANA (Anti-Nuclear Antibodies)"
        InvestigationBloods Bloods.Bilirubin -> "Bilirubin"
        InvestigationBloods Bloods.CKCreatineKinase -> "CK (Creatine Kinase)"
        InvestigationBloods Bloods.ESRErythrocyteSedimentationRate -> "ESR (Erythrocyte Sedimentation Rate)"
        InvestigationBloods Bloods.FBGFastingBloodGlucose -> "FBG (Fasting Blood Glucose)"
        InvestigationBloods Bloods.Iron -> "Iron"
        InvestigationBloods Bloods.Lactate -> "Lactate"
        InvestigationBloods Bloods.LDHLactateDehydrogenase -> "LDH (Lactate Dehydrogenase)"
        InvestigationBloods Bloods.Lipids -> "Lipids"
        InvestigationBloods Bloods.TFTThyroidFunctionTests -> "TFT (Thyroid Function Tests)"
        InvestigationBloods Bloods.APTTActivatedpartialthromboplastintime -> "aPTT (Activated partial thromboplastin time)"
        InvestigationBloods Bloods.PTProthrombintime -> "PT (Prothrombin time)"
        InvestigationImaging Imaging.CXRChestXray -> "CXR (Chest X-ray)"
        InvestigationImaging Imaging.AXRAbdominalXray -> "AXR (Abdominal X-ray)"
        InvestigationImaging Imaging.CTBCTBrain -> "CTB (CT Brain)"
        InvestigationImaging Imaging.MRIBrain -> "MRI Brain"
        InvestigationImaging Imaging.CTAbdoPelvis -> "CT Abdo Pelvis"
        InvestigationOther Other.ECGElectrocardiogram -> "ECG (Electrocardiogram)"
        InvestigationOther Other.Spirometry -> "Spirometry"
        InvestigationOther Other.Echocardiogram -> "Echocardiogram"
        InvestigationOther Other.EEGElectroencephalography -> "EEG (Electroencephalography)"
        InvestigationCSF CSF.CSFMCS -> "CSF M/C/S"
        InvestigationCSF CSF.CSFcytology -> "CSF cytology"
        InvestigationCSF CSF.CSFglucose -> "CSF glucose"
        InvestigationCSF CSF.CSFelectrophoresis -> "CSF electrophoresis"
        InvestigationCSF CSF.CSFcellcount -> "CSF cell count"

list : List Investigation
list = 
    [ InvestigationBloods Bloods.FBEFullBloodExamination
    , InvestigationBloods Bloods.UECUreaElectrolytesandCreatinine
    , InvestigationBloods Bloods.LFTLiverFunctionTests
    , InvestigationBloods Bloods.Troponin
    , InvestigationBloods Bloods.CMPCalciumMagnesiumPhosphate
    , InvestigationBloods Bloods.CRPCReactiveProtein
    , InvestigationBloods Bloods.Amylase
    , InvestigationBloods Bloods.ANAAntiNuclearAntibodies
    , InvestigationBloods Bloods.Bilirubin
    , InvestigationBloods Bloods.CKCreatineKinase
    , InvestigationBloods Bloods.ESRErythrocyteSedimentationRate
    , InvestigationBloods Bloods.FBGFastingBloodGlucose
    , InvestigationBloods Bloods.Iron
    , InvestigationBloods Bloods.Lactate
    , InvestigationBloods Bloods.LDHLactateDehydrogenase
    , InvestigationBloods Bloods.Lipids
    , InvestigationBloods Bloods.TFTThyroidFunctionTests
    , InvestigationBloods Bloods.APTTActivatedpartialthromboplastintime
    , InvestigationBloods Bloods.PTProthrombintime
    , InvestigationImaging Imaging.CXRChestXray
    , InvestigationImaging Imaging.AXRAbdominalXray
    , InvestigationImaging Imaging.CTBCTBrain
    , InvestigationImaging Imaging.MRIBrain
    , InvestigationImaging Imaging.CTAbdoPelvis
    , InvestigationOther Other.ECGElectrocardiogram
    , InvestigationOther Other.Spirometry
    , InvestigationOther Other.Echocardiogram
    , InvestigationOther Other.EEGElectroencephalography
    , InvestigationCSF CSF.CSFMCS
    , InvestigationCSF CSF.CSFcytology
    , InvestigationCSF CSF.CSFglucose
    , InvestigationCSF CSF.CSFelectrophoresis
    , InvestigationCSF CSF.CSFcellcount ]

optionList : (Investigation -> String -> msg) -> List (Option.Data Investigation msg)
optionList msg =
    [ { value = InvestigationBloods Bloods.FBEFullBloodExamination, string = "FBE (Full Blood Examination)", onClick = msg (InvestigationBloods Bloods.FBEFullBloodExamination) "FBE (Full Blood Examination)", tags = "" }
    , { value = InvestigationBloods Bloods.UECUreaElectrolytesandCreatinine, string = "UEC (Urea, Electrolytes and Creatinine)", onClick = msg (InvestigationBloods Bloods.UECUreaElectrolytesandCreatinine) "UEC (Urea, Electrolytes and Creatinine)", tags = "" }
    , { value = InvestigationBloods Bloods.LFTLiverFunctionTests, string = "LFT (Liver Function Tests)", onClick = msg (InvestigationBloods Bloods.LFTLiverFunctionTests) "LFT (Liver Function Tests)", tags = "" }
    , { value = InvestigationBloods Bloods.Troponin, string = "Troponin", onClick = msg (InvestigationBloods Bloods.Troponin) "Troponin", tags = "" }
    , { value = InvestigationBloods Bloods.CMPCalciumMagnesiumPhosphate, string = "CMP (Calcium Magnesium Phosphate)", onClick = msg (InvestigationBloods Bloods.CMPCalciumMagnesiumPhosphate) "CMP (Calcium Magnesium Phosphate)", tags = "" }
    , { value = InvestigationBloods Bloods.CRPCReactiveProtein, string = "CRP (C-Reactive Protein)", onClick = msg (InvestigationBloods Bloods.CRPCReactiveProtein) "CRP (C-Reactive Protein)", tags = "" }
    , { value = InvestigationBloods Bloods.Amylase, string = "Amylase", onClick = msg (InvestigationBloods Bloods.Amylase) "Amylase", tags = "" }
    , { value = InvestigationBloods Bloods.ANAAntiNuclearAntibodies, string = "ANA (Anti-Nuclear Antibodies)", onClick = msg (InvestigationBloods Bloods.ANAAntiNuclearAntibodies) "ANA (Anti-Nuclear Antibodies)", tags = "" }
    , { value = InvestigationBloods Bloods.Bilirubin, string = "Bilirubin", onClick = msg (InvestigationBloods Bloods.Bilirubin) "Bilirubin", tags = "" }
    , { value = InvestigationBloods Bloods.CKCreatineKinase, string = "CK (Creatine Kinase)", onClick = msg (InvestigationBloods Bloods.CKCreatineKinase) "CK (Creatine Kinase)", tags = "" }
    , { value = InvestigationBloods Bloods.ESRErythrocyteSedimentationRate, string = "ESR (Erythrocyte Sedimentation Rate)", onClick = msg (InvestigationBloods Bloods.ESRErythrocyteSedimentationRate) "ESR (Erythrocyte Sedimentation Rate)", tags = "" }
    , { value = InvestigationBloods Bloods.FBGFastingBloodGlucose, string = "FBG (Fasting Blood Glucose)", onClick = msg (InvestigationBloods Bloods.FBGFastingBloodGlucose) "FBG (Fasting Blood Glucose)", tags = "" }
    , { value = InvestigationBloods Bloods.Iron, string = "Iron", onClick = msg (InvestigationBloods Bloods.Iron) "Iron", tags = "" }
    , { value = InvestigationBloods Bloods.Lactate, string = "Lactate", onClick = msg (InvestigationBloods Bloods.Lactate) "Lactate", tags = "" }
    , { value = InvestigationBloods Bloods.LDHLactateDehydrogenase, string = "LDH (Lactate Dehydrogenase)", onClick = msg (InvestigationBloods Bloods.LDHLactateDehydrogenase) "LDH (Lactate Dehydrogenase)", tags = "" }
    , { value = InvestigationBloods Bloods.Lipids, string = "Lipids", onClick = msg (InvestigationBloods Bloods.Lipids) "Lipids", tags = "" }
    , { value = InvestigationBloods Bloods.TFTThyroidFunctionTests, string = "TFT (Thyroid Function Tests)", onClick = msg (InvestigationBloods Bloods.TFTThyroidFunctionTests) "TFT (Thyroid Function Tests)", tags = "" }
    , { value = InvestigationBloods Bloods.APTTActivatedpartialthromboplastintime, string = "aPTT (Activated partial thromboplastin time)", onClick = msg (InvestigationBloods Bloods.APTTActivatedpartialthromboplastintime) "aPTT (Activated partial thromboplastin time)", tags = "" }
    , { value = InvestigationBloods Bloods.PTProthrombintime, string = "PT (Prothrombin time)", onClick = msg (InvestigationBloods Bloods.PTProthrombintime) "PT (Prothrombin time)", tags = "" }
    , { value = InvestigationImaging Imaging.CXRChestXray, string = "CXR (Chest X-ray)", onClick = msg (InvestigationImaging Imaging.CXRChestXray) "CXR (Chest X-ray)", tags = "" }
    , { value = InvestigationImaging Imaging.AXRAbdominalXray, string = "AXR (Abdominal X-ray)", onClick = msg (InvestigationImaging Imaging.AXRAbdominalXray) "AXR (Abdominal X-ray)", tags = "" }
    , { value = InvestigationImaging Imaging.CTBCTBrain, string = "CTB (CT Brain)", onClick = msg (InvestigationImaging Imaging.CTBCTBrain) "CTB (CT Brain)", tags = "" }
    , { value = InvestigationImaging Imaging.MRIBrain, string = "MRI Brain", onClick = msg (InvestigationImaging Imaging.MRIBrain) "MRI Brain", tags = "" }
    , { value = InvestigationImaging Imaging.CTAbdoPelvis, string = "CT Abdo Pelvis", onClick = msg (InvestigationImaging Imaging.CTAbdoPelvis) "CT Abdo Pelvis", tags = "" }
    , { value = InvestigationOther Other.ECGElectrocardiogram, string = "ECG (Electrocardiogram)", onClick = msg (InvestigationOther Other.ECGElectrocardiogram) "ECG (Electrocardiogram)", tags = "" }
    , { value = InvestigationOther Other.Spirometry, string = "Spirometry", onClick = msg (InvestigationOther Other.Spirometry) "Spirometry", tags = "" }
    , { value = InvestigationOther Other.Echocardiogram, string = "Echocardiogram", onClick = msg (InvestigationOther Other.Echocardiogram) "Echocardiogram", tags = "" }
    , { value = InvestigationOther Other.EEGElectroencephalography, string = "EEG (Electroencephalography)", onClick = msg (InvestigationOther Other.EEGElectroencephalography) "EEG (Electroencephalography)", tags = "" }
    , { value = InvestigationCSF CSF.CSFMCS, string = "CSF M/C/S", onClick = msg (InvestigationCSF CSF.CSFMCS) "CSF M/C/S", tags = "" }
    , { value = InvestigationCSF CSF.CSFcytology, string = "CSF cytology", onClick = msg (InvestigationCSF CSF.CSFcytology) "CSF cytology", tags = "" }
    , { value = InvestigationCSF CSF.CSFglucose, string = "CSF glucose", onClick = msg (InvestigationCSF CSF.CSFglucose) "CSF glucose", tags = "" }
    , { value = InvestigationCSF CSF.CSFelectrophoresis, string = "CSF electrophoresis", onClick = msg (InvestigationCSF CSF.CSFelectrophoresis) "CSF electrophoresis", tags = "" }
    , { value = InvestigationCSF CSF.CSFcellcount, string = "CSF cell count", onClick = msg (InvestigationCSF CSF.CSFcellcount) "CSF cell count", tags = "" } ]

