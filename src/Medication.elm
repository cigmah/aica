module Medication exposing (..)

import Option



type Medication = Acarbose
    | Acetazolamide
    | Acetylcysteine
    | Aciclovir
    | Activatedcharcoal
    | Adenosine
    | Adrenaline
    | Albendazole
    | Alendronate
    | Allopurinol
    | Alteplase
    | Amiodarone
    | Amlodipine
    | Amoxicillin
    | AmphotericinB
    | Anakinra
    | Anastrozole
    | Antivenom
    | Aspirin
    | Atenolol
    | Atorvastatin
    | AtovaquoneProguanil
    | Atropine
    | Azathioprine
    | Benzatropine
    | Bupivacaine
    | Calciumgluconate
    | Carbamazepine
    | Carbimazole
    | Caspofungin
    | Cefalexin
    | Chlorpromazine
    | Ciclosporin
    | Ciprofloxacin
    | Clarithromycin
    | Clomifene
    | Clonazepam
    | Clopidogrel
    | Clozapine
    | Codeine
    | Colchicine
    | Cromoglycate
    | Cyclophosphamide
    | Dabigatran
    | Denosumab
    | Dexamethasone
    | Dexamfetamine
    | Diazepam
    | Diclofenac
    | Digoxin
    | Digoxinspecificantibody
    | Disulfiram
    | Docusate
    | Donepezil
    | Doxorubicin
    | Doxycycline
    | Enoxaparin
    | Epoetinalfa
    | Erythromycin
    | Esomeprazole
    | Ethinylestradiol
    | Ethosuximide
    | Exenatide
    | Ezetimibe
    | Fenofibrate
    | Fentanyl
    | Finasteride
    | Fluconazole
    | Fluorouracil
    | Fluoxetine
    | Fluticasone
    | Formoterol
    | Furosemide
    | Gentamicin
    | Gliclazide
    | Glucagon
    | Glyceryltrinitrate
    | Haloperidol
    | Heparin
    | Hydrochlorothiazide
    | Hyoscine
    | Ibuprofen
    | Imipramine
    | Infliximab
    | Insulin
    | Interferonalfa
    | Ipratropium
    | Irbesartan
    | Isoniazid
    | Ivermectin
    | Ketamine
    | Labetalol
    | Lactulose
    | Leflunomide
    | LevodopaCarbidopa
    | Levonorgestrel
    | Levothyroxine
    | Lidocaine
    | Lithium
    | Loperamide
    | Loratadine
    | Magnesiumsulfate
    | Meloxicam
    | Metformin
    | Methadone
    | Methotrexate
    | Methoxyflurane
    | Metoclopramide
    | Metronidazole
    | Midazolam
    | Mirtazapine
    | Misoprostol
    | Moclobemide
    | Montelukast
    | Morphine
    | Naloxone
    | Nicotine
    | Nifedipine
    | Nimodipine
    | Nitrousoxide
    | Olanzapine
    | Ondansetron
    | Orlistat
    | Oseltamivir
    | Oxybutynin
    | Oxytocin
    | Paracetamol
    | Perindopril
    | Phenytoin
    | Pramipexole
    | Prazosin
    | Prednisolone
    | Prochlorperazine
    | Promethazine
    | Propofol
    | Pyridostigmine
    | Quetiapine
    | Quinine
    | Ranitidine
    | Rifampicin
    | Risperidone
    | Ritonavir
    | Rocuronium
    | Salbutamol
    | Selegiline
    | Senna
    | Sevoflurane
    | Sildenafil
    | Sirolimus
    | Sitagliptin
    | Somatropin
    | Spironolactone
    | Sucralfate
    | Sulfasalazine
    | Suxamethonium
    | Tamoxifen
    | Tamsulosin
    | Tenofoviremtricitabine
    | Testosterone
    | Tetracaine
    | Thiopental
    | Tramadol
    | Trastuzumab
    | Valproate
    | Vancomycin
    | Venlafaxine
    | Verapamil
    | Warfarin
    | Zolpidem

fromInt : Int -> Medication
fromInt int = 
    case int of
        0 -> Acarbose
        1 -> Acetazolamide
        2 -> Acetylcysteine
        3 -> Aciclovir
        4 -> Activatedcharcoal
        5 -> Adenosine
        6 -> Adrenaline
        7 -> Albendazole
        8 -> Alendronate
        9 -> Allopurinol
        10 -> Alteplase
        11 -> Amiodarone
        12 -> Amlodipine
        13 -> Amoxicillin
        14 -> AmphotericinB
        15 -> Anakinra
        16 -> Anastrozole
        17 -> Antivenom
        18 -> Aspirin
        19 -> Atenolol
        20 -> Atorvastatin
        21 -> AtovaquoneProguanil
        22 -> Atropine
        23 -> Azathioprine
        24 -> Benzatropine
        25 -> Bupivacaine
        26 -> Calciumgluconate
        27 -> Carbamazepine
        28 -> Carbimazole
        29 -> Caspofungin
        30 -> Cefalexin
        31 -> Chlorpromazine
        32 -> Ciclosporin
        33 -> Ciprofloxacin
        34 -> Clarithromycin
        35 -> Clomifene
        36 -> Clonazepam
        37 -> Clopidogrel
        38 -> Clozapine
        39 -> Codeine
        40 -> Colchicine
        41 -> Cromoglycate
        42 -> Cyclophosphamide
        43 -> Dabigatran
        44 -> Denosumab
        45 -> Dexamethasone
        46 -> Dexamfetamine
        47 -> Diazepam
        48 -> Diclofenac
        49 -> Digoxin
        50 -> Digoxinspecificantibody
        51 -> Disulfiram
        52 -> Docusate
        53 -> Donepezil
        54 -> Doxorubicin
        55 -> Doxycycline
        56 -> Enoxaparin
        57 -> Epoetinalfa
        58 -> Erythromycin
        59 -> Esomeprazole
        60 -> Ethinylestradiol
        61 -> Ethosuximide
        62 -> Exenatide
        63 -> Ezetimibe
        64 -> Fenofibrate
        65 -> Fentanyl
        66 -> Finasteride
        67 -> Fluconazole
        68 -> Fluorouracil
        69 -> Fluoxetine
        70 -> Fluticasone
        71 -> Formoterol
        72 -> Furosemide
        73 -> Gentamicin
        74 -> Gliclazide
        75 -> Glucagon
        76 -> Glyceryltrinitrate
        77 -> Haloperidol
        78 -> Heparin
        79 -> Hydrochlorothiazide
        80 -> Hyoscine
        81 -> Ibuprofen
        82 -> Imipramine
        83 -> Infliximab
        84 -> Insulin
        85 -> Interferonalfa
        86 -> Ipratropium
        87 -> Irbesartan
        88 -> Isoniazid
        89 -> Ivermectin
        90 -> Ketamine
        91 -> Labetalol
        92 -> Lactulose
        93 -> Leflunomide
        94 -> LevodopaCarbidopa
        95 -> Levonorgestrel
        96 -> Levothyroxine
        97 -> Lidocaine
        98 -> Lithium
        99 -> Loperamide
        100 -> Loratadine
        101 -> Magnesiumsulfate
        102 -> Meloxicam
        103 -> Metformin
        104 -> Methadone
        105 -> Methotrexate
        106 -> Methoxyflurane
        107 -> Metoclopramide
        108 -> Metronidazole
        109 -> Midazolam
        110 -> Mirtazapine
        111 -> Misoprostol
        112 -> Moclobemide
        113 -> Montelukast
        114 -> Morphine
        115 -> Naloxone
        116 -> Nicotine
        117 -> Nifedipine
        118 -> Nimodipine
        119 -> Nitrousoxide
        120 -> Olanzapine
        121 -> Ondansetron
        122 -> Orlistat
        123 -> Oseltamivir
        124 -> Oxybutynin
        125 -> Oxytocin
        126 -> Paracetamol
        127 -> Perindopril
        128 -> Phenytoin
        129 -> Pramipexole
        130 -> Prazosin
        131 -> Prednisolone
        132 -> Prochlorperazine
        133 -> Promethazine
        134 -> Propofol
        135 -> Pyridostigmine
        136 -> Quetiapine
        137 -> Quinine
        138 -> Ranitidine
        139 -> Rifampicin
        140 -> Risperidone
        141 -> Ritonavir
        142 -> Rocuronium
        143 -> Salbutamol
        144 -> Selegiline
        145 -> Senna
        146 -> Sevoflurane
        147 -> Sildenafil
        148 -> Sirolimus
        149 -> Sitagliptin
        150 -> Somatropin
        151 -> Spironolactone
        152 -> Sucralfate
        153 -> Sulfasalazine
        154 -> Suxamethonium
        155 -> Tamoxifen
        156 -> Tamsulosin
        157 -> Tenofoviremtricitabine
        158 -> Testosterone
        159 -> Tetracaine
        160 -> Thiopental
        161 -> Tramadol
        162 -> Trastuzumab
        163 -> Valproate
        164 -> Vancomycin
        165 -> Venlafaxine
        166 -> Verapamil
        167 -> Warfarin
        168 -> Zolpidem
        _ -> Acarbose

toInt : Medication -> Int
toInt enum = 
    case enum of 
        Acarbose -> 0
        Acetazolamide -> 1
        Acetylcysteine -> 2
        Aciclovir -> 3
        Activatedcharcoal -> 4
        Adenosine -> 5
        Adrenaline -> 6
        Albendazole -> 7
        Alendronate -> 8
        Allopurinol -> 9
        Alteplase -> 10
        Amiodarone -> 11
        Amlodipine -> 12
        Amoxicillin -> 13
        AmphotericinB -> 14
        Anakinra -> 15
        Anastrozole -> 16
        Antivenom -> 17
        Aspirin -> 18
        Atenolol -> 19
        Atorvastatin -> 20
        AtovaquoneProguanil -> 21
        Atropine -> 22
        Azathioprine -> 23
        Benzatropine -> 24
        Bupivacaine -> 25
        Calciumgluconate -> 26
        Carbamazepine -> 27
        Carbimazole -> 28
        Caspofungin -> 29
        Cefalexin -> 30
        Chlorpromazine -> 31
        Ciclosporin -> 32
        Ciprofloxacin -> 33
        Clarithromycin -> 34
        Clomifene -> 35
        Clonazepam -> 36
        Clopidogrel -> 37
        Clozapine -> 38
        Codeine -> 39
        Colchicine -> 40
        Cromoglycate -> 41
        Cyclophosphamide -> 42
        Dabigatran -> 43
        Denosumab -> 44
        Dexamethasone -> 45
        Dexamfetamine -> 46
        Diazepam -> 47
        Diclofenac -> 48
        Digoxin -> 49
        Digoxinspecificantibody -> 50
        Disulfiram -> 51
        Docusate -> 52
        Donepezil -> 53
        Doxorubicin -> 54
        Doxycycline -> 55
        Enoxaparin -> 56
        Epoetinalfa -> 57
        Erythromycin -> 58
        Esomeprazole -> 59
        Ethinylestradiol -> 60
        Ethosuximide -> 61
        Exenatide -> 62
        Ezetimibe -> 63
        Fenofibrate -> 64
        Fentanyl -> 65
        Finasteride -> 66
        Fluconazole -> 67
        Fluorouracil -> 68
        Fluoxetine -> 69
        Fluticasone -> 70
        Formoterol -> 71
        Furosemide -> 72
        Gentamicin -> 73
        Gliclazide -> 74
        Glucagon -> 75
        Glyceryltrinitrate -> 76
        Haloperidol -> 77
        Heparin -> 78
        Hydrochlorothiazide -> 79
        Hyoscine -> 80
        Ibuprofen -> 81
        Imipramine -> 82
        Infliximab -> 83
        Insulin -> 84
        Interferonalfa -> 85
        Ipratropium -> 86
        Irbesartan -> 87
        Isoniazid -> 88
        Ivermectin -> 89
        Ketamine -> 90
        Labetalol -> 91
        Lactulose -> 92
        Leflunomide -> 93
        LevodopaCarbidopa -> 94
        Levonorgestrel -> 95
        Levothyroxine -> 96
        Lidocaine -> 97
        Lithium -> 98
        Loperamide -> 99
        Loratadine -> 100
        Magnesiumsulfate -> 101
        Meloxicam -> 102
        Metformin -> 103
        Methadone -> 104
        Methotrexate -> 105
        Methoxyflurane -> 106
        Metoclopramide -> 107
        Metronidazole -> 108
        Midazolam -> 109
        Mirtazapine -> 110
        Misoprostol -> 111
        Moclobemide -> 112
        Montelukast -> 113
        Morphine -> 114
        Naloxone -> 115
        Nicotine -> 116
        Nifedipine -> 117
        Nimodipine -> 118
        Nitrousoxide -> 119
        Olanzapine -> 120
        Ondansetron -> 121
        Orlistat -> 122
        Oseltamivir -> 123
        Oxybutynin -> 124
        Oxytocin -> 125
        Paracetamol -> 126
        Perindopril -> 127
        Phenytoin -> 128
        Pramipexole -> 129
        Prazosin -> 130
        Prednisolone -> 131
        Prochlorperazine -> 132
        Promethazine -> 133
        Propofol -> 134
        Pyridostigmine -> 135
        Quetiapine -> 136
        Quinine -> 137
        Ranitidine -> 138
        Rifampicin -> 139
        Risperidone -> 140
        Ritonavir -> 141
        Rocuronium -> 142
        Salbutamol -> 143
        Selegiline -> 144
        Senna -> 145
        Sevoflurane -> 146
        Sildenafil -> 147
        Sirolimus -> 148
        Sitagliptin -> 149
        Somatropin -> 150
        Spironolactone -> 151
        Sucralfate -> 152
        Sulfasalazine -> 153
        Suxamethonium -> 154
        Tamoxifen -> 155
        Tamsulosin -> 156
        Tenofoviremtricitabine -> 157
        Testosterone -> 158
        Tetracaine -> 159
        Thiopental -> 160
        Tramadol -> 161
        Trastuzumab -> 162
        Valproate -> 163
        Vancomycin -> 164
        Venlafaxine -> 165
        Verapamil -> 166
        Warfarin -> 167
        Zolpidem -> 168

toString : Medication -> String
toString enum = 
    case enum of
        Acarbose -> "Acarbose"
        Acetazolamide -> "Acetazolamide"
        Acetylcysteine -> "Acetylcysteine"
        Aciclovir -> "Aciclovir"
        Activatedcharcoal -> "Activated charcoal"
        Adenosine -> "Adenosine"
        Adrenaline -> "Adrenaline"
        Albendazole -> "Albendazole"
        Alendronate -> "Alendronate"
        Allopurinol -> "Allopurinol"
        Alteplase -> "Alteplase"
        Amiodarone -> "Amiodarone"
        Amlodipine -> "Amlodipine"
        Amoxicillin -> "Amoxicillin"
        AmphotericinB -> "Amphotericin B"
        Anakinra -> "Anakinra"
        Anastrozole -> "Anastrozole"
        Antivenom -> "Antivenom"
        Aspirin -> "Aspirin"
        Atenolol -> "Atenolol"
        Atorvastatin -> "Atorvastatin"
        AtovaquoneProguanil -> "Atovaquone/Proguanil"
        Atropine -> "Atropine"
        Azathioprine -> "Azathioprine"
        Benzatropine -> "Benzatropine"
        Bupivacaine -> "Bupivacaine"
        Calciumgluconate -> "Calcium gluconate"
        Carbamazepine -> "Carbamazepine"
        Carbimazole -> "Carbimazole"
        Caspofungin -> "Caspofungin"
        Cefalexin -> "Cefalexin"
        Chlorpromazine -> "Chlorpromazine"
        Ciclosporin -> "Ciclosporin"
        Ciprofloxacin -> "Ciprofloxacin"
        Clarithromycin -> "Clarithromycin"
        Clomifene -> "Clomifene "
        Clonazepam -> "Clonazepam"
        Clopidogrel -> "Clopidogrel"
        Clozapine -> "Clozapine"
        Codeine -> "Codeine"
        Colchicine -> "Colchicine"
        Cromoglycate -> "Cromoglycate"
        Cyclophosphamide -> "Cyclophosphamide"
        Dabigatran -> "Dabigatran"
        Denosumab -> "Denosumab"
        Dexamethasone -> "Dexamethasone"
        Dexamfetamine -> "Dexamfetamine"
        Diazepam -> "Diazepam"
        Diclofenac -> "Diclofenac"
        Digoxin -> "Digoxin"
        Digoxinspecificantibody -> "Digoxin-specific antibody"
        Disulfiram -> "Disulfiram"
        Docusate -> "Docusate"
        Donepezil -> "Donepezil"
        Doxorubicin -> "Doxorubicin"
        Doxycycline -> "Doxycycline"
        Enoxaparin -> "Enoxaparin"
        Epoetinalfa -> "Epoetin alfa"
        Erythromycin -> "Erythromycin"
        Esomeprazole -> "Esomeprazole"
        Ethinylestradiol -> "Ethinylestradiol"
        Ethosuximide -> "Ethosuximide"
        Exenatide -> "Exenatide"
        Ezetimibe -> "Ezetimibe"
        Fenofibrate -> "Fenofibrate"
        Fentanyl -> "Fentanyl"
        Finasteride -> "Finasteride"
        Fluconazole -> "Fluconazole"
        Fluorouracil -> "Fluorouracil"
        Fluoxetine -> "Fluoxetine"
        Fluticasone -> "Fluticasone"
        Formoterol -> "Formoterol"
        Furosemide -> "Furosemide"
        Gentamicin -> "Gentamicin"
        Gliclazide -> "Gliclazide"
        Glucagon -> "Glucagon"
        Glyceryltrinitrate -> "Glyceryl trinitrate"
        Haloperidol -> "Haloperidol"
        Heparin -> "Heparin"
        Hydrochlorothiazide -> "Hydrochlorothiazide"
        Hyoscine -> "Hyoscine"
        Ibuprofen -> "Ibuprofen"
        Imipramine -> "Imipramine"
        Infliximab -> "Infliximab"
        Insulin -> "Insulin"
        Interferonalfa -> "Interferon alfa"
        Ipratropium -> "Ipratropium"
        Irbesartan -> "Irbesartan"
        Isoniazid -> "Isoniazid"
        Ivermectin -> "Ivermectin"
        Ketamine -> "Ketamine"
        Labetalol -> "Labetalol"
        Lactulose -> "Lactulose"
        Leflunomide -> "Leflunomide"
        LevodopaCarbidopa -> "Levodopa/Carbidopa"
        Levonorgestrel -> "Levonorgestrel"
        Levothyroxine -> "Levothyroxine "
        Lidocaine -> "Lidocaine"
        Lithium -> "Lithium"
        Loperamide -> "Loperamide"
        Loratadine -> "Loratadine"
        Magnesiumsulfate -> "Magnesium sulfate"
        Meloxicam -> "Meloxicam"
        Metformin -> "Metformin"
        Methadone -> "Methadone"
        Methotrexate -> "Methotrexate"
        Methoxyflurane -> "Methoxyflurane"
        Metoclopramide -> "Metoclopramide"
        Metronidazole -> "Metronidazole"
        Midazolam -> "Midazolam"
        Mirtazapine -> "Mirtazapine"
        Misoprostol -> "Misoprostol"
        Moclobemide -> "Moclobemide"
        Montelukast -> "Montelukast"
        Morphine -> "Morphine"
        Naloxone -> "Naloxone"
        Nicotine -> "Nicotine"
        Nifedipine -> "Nifedipine"
        Nimodipine -> "Nimodipine"
        Nitrousoxide -> "Nitrous oxide"
        Olanzapine -> "Olanzapine"
        Ondansetron -> "Ondansetron"
        Orlistat -> "Orlistat"
        Oseltamivir -> "Oseltamivir"
        Oxybutynin -> "Oxybutynin"
        Oxytocin -> "Oxytocin"
        Paracetamol -> "Paracetamol"
        Perindopril -> "Perindopril"
        Phenytoin -> "Phenytoin"
        Pramipexole -> "Pramipexole"
        Prazosin -> "Prazosin"
        Prednisolone -> "Prednisolone"
        Prochlorperazine -> "Prochlorperazine"
        Promethazine -> "Promethazine"
        Propofol -> "Propofol"
        Pyridostigmine -> "Pyridostigmine"
        Quetiapine -> "Quetiapine"
        Quinine -> "Quinine"
        Ranitidine -> "Ranitidine"
        Rifampicin -> "Rifampicin"
        Risperidone -> "Risperidone"
        Ritonavir -> "Ritonavir"
        Rocuronium -> "Rocuronium"
        Salbutamol -> "Salbutamol"
        Selegiline -> "Selegiline"
        Senna -> "Senna"
        Sevoflurane -> "Sevoflurane"
        Sildenafil -> "Sildenafil"
        Sirolimus -> "Sirolimus"
        Sitagliptin -> "Sitagliptin"
        Somatropin -> "Somatropin"
        Spironolactone -> "Spironolactone"
        Sucralfate -> "Sucralfate"
        Sulfasalazine -> "Sulfasalazine"
        Suxamethonium -> "Suxamethonium"
        Tamoxifen -> "Tamoxifen"
        Tamsulosin -> "Tamsulosin"
        Tenofoviremtricitabine -> "Tenofovir/emtricitabine"
        Testosterone -> "Testosterone"
        Tetracaine -> "Tetracaine"
        Thiopental -> "Thiopental"
        Tramadol -> "Tramadol"
        Trastuzumab -> "Trastuzumab"
        Valproate -> "Valproate"
        Vancomycin -> "Vancomycin"
        Venlafaxine -> "Venlafaxine"
        Verapamil -> "Verapamil"
        Warfarin -> "Warfarin "
        Zolpidem -> "Zolpidem"

list : List Medication
list = 
    [ Acarbose
    , Acetazolamide
    , Acetylcysteine
    , Aciclovir
    , Activatedcharcoal
    , Adenosine
    , Adrenaline
    , Albendazole
    , Alendronate
    , Allopurinol
    , Alteplase
    , Amiodarone
    , Amlodipine
    , Amoxicillin
    , AmphotericinB
    , Anakinra
    , Anastrozole
    , Antivenom
    , Aspirin
    , Atenolol
    , Atorvastatin
    , AtovaquoneProguanil
    , Atropine
    , Azathioprine
    , Benzatropine
    , Bupivacaine
    , Calciumgluconate
    , Carbamazepine
    , Carbimazole
    , Caspofungin
    , Cefalexin
    , Chlorpromazine
    , Ciclosporin
    , Ciprofloxacin
    , Clarithromycin
    , Clomifene
    , Clonazepam
    , Clopidogrel
    , Clozapine
    , Codeine
    , Colchicine
    , Cromoglycate
    , Cyclophosphamide
    , Dabigatran
    , Denosumab
    , Dexamethasone
    , Dexamfetamine
    , Diazepam
    , Diclofenac
    , Digoxin
    , Digoxinspecificantibody
    , Disulfiram
    , Docusate
    , Donepezil
    , Doxorubicin
    , Doxycycline
    , Enoxaparin
    , Epoetinalfa
    , Erythromycin
    , Esomeprazole
    , Ethinylestradiol
    , Ethosuximide
    , Exenatide
    , Ezetimibe
    , Fenofibrate
    , Fentanyl
    , Finasteride
    , Fluconazole
    , Fluorouracil
    , Fluoxetine
    , Fluticasone
    , Formoterol
    , Furosemide
    , Gentamicin
    , Gliclazide
    , Glucagon
    , Glyceryltrinitrate
    , Haloperidol
    , Heparin
    , Hydrochlorothiazide
    , Hyoscine
    , Ibuprofen
    , Imipramine
    , Infliximab
    , Insulin
    , Interferonalfa
    , Ipratropium
    , Irbesartan
    , Isoniazid
    , Ivermectin
    , Ketamine
    , Labetalol
    , Lactulose
    , Leflunomide
    , LevodopaCarbidopa
    , Levonorgestrel
    , Levothyroxine
    , Lidocaine
    , Lithium
    , Loperamide
    , Loratadine
    , Magnesiumsulfate
    , Meloxicam
    , Metformin
    , Methadone
    , Methotrexate
    , Methoxyflurane
    , Metoclopramide
    , Metronidazole
    , Midazolam
    , Mirtazapine
    , Misoprostol
    , Moclobemide
    , Montelukast
    , Morphine
    , Naloxone
    , Nicotine
    , Nifedipine
    , Nimodipine
    , Nitrousoxide
    , Olanzapine
    , Ondansetron
    , Orlistat
    , Oseltamivir
    , Oxybutynin
    , Oxytocin
    , Paracetamol
    , Perindopril
    , Phenytoin
    , Pramipexole
    , Prazosin
    , Prednisolone
    , Prochlorperazine
    , Promethazine
    , Propofol
    , Pyridostigmine
    , Quetiapine
    , Quinine
    , Ranitidine
    , Rifampicin
    , Risperidone
    , Ritonavir
    , Rocuronium
    , Salbutamol
    , Selegiline
    , Senna
    , Sevoflurane
    , Sildenafil
    , Sirolimus
    , Sitagliptin
    , Somatropin
    , Spironolactone
    , Sucralfate
    , Sulfasalazine
    , Suxamethonium
    , Tamoxifen
    , Tamsulosin
    , Tenofoviremtricitabine
    , Testosterone
    , Tetracaine
    , Thiopental
    , Tramadol
    , Trastuzumab
    , Valproate
    , Vancomycin
    , Venlafaxine
    , Verapamil
    , Warfarin
    , Zolpidem ]

optionList : (Medication -> String -> msg) -> List (Option.Data Medication msg) 
optionList msg = 
    [ { value = Acarbose, string = "Acarbose", onClick = msg (Acarbose) "Acarbose", tags = "" }
    , { value = Acetazolamide, string = "Acetazolamide", onClick = msg (Acetazolamide) "Acetazolamide", tags = "" }
    , { value = Acetylcysteine, string = "Acetylcysteine", onClick = msg (Acetylcysteine) "Acetylcysteine", tags = "" }
    , { value = Aciclovir, string = "Aciclovir", onClick = msg (Aciclovir) "Aciclovir", tags = "" }
    , { value = Activatedcharcoal, string = "Activated charcoal", onClick = msg (Activatedcharcoal) "Activated charcoal", tags = "" }
    , { value = Adenosine, string = "Adenosine", onClick = msg (Adenosine) "Adenosine", tags = "" }
    , { value = Adrenaline, string = "Adrenaline", onClick = msg (Adrenaline) "Adrenaline", tags = "" }
    , { value = Albendazole, string = "Albendazole", onClick = msg (Albendazole) "Albendazole", tags = "" }
    , { value = Alendronate, string = "Alendronate", onClick = msg (Alendronate) "Alendronate", tags = "" }
    , { value = Allopurinol, string = "Allopurinol", onClick = msg (Allopurinol) "Allopurinol", tags = "" }
    , { value = Alteplase, string = "Alteplase", onClick = msg (Alteplase) "Alteplase", tags = "" }
    , { value = Amiodarone, string = "Amiodarone", onClick = msg (Amiodarone) "Amiodarone", tags = "" }
    , { value = Amlodipine, string = "Amlodipine", onClick = msg (Amlodipine) "Amlodipine", tags = "" }
    , { value = Amoxicillin, string = "Amoxicillin", onClick = msg (Amoxicillin) "Amoxicillin", tags = "" }
    , { value = AmphotericinB, string = "Amphotericin B", onClick = msg (AmphotericinB) "Amphotericin B", tags = "" }
    , { value = Anakinra, string = "Anakinra", onClick = msg (Anakinra) "Anakinra", tags = "" }
    , { value = Anastrozole, string = "Anastrozole", onClick = msg (Anastrozole) "Anastrozole", tags = "" }
    , { value = Antivenom, string = "Antivenom", onClick = msg (Antivenom) "Antivenom", tags = "" }
    , { value = Aspirin, string = "Aspirin", onClick = msg (Aspirin) "Aspirin", tags = "" }
    , { value = Atenolol, string = "Atenolol", onClick = msg (Atenolol) "Atenolol", tags = "" }
    , { value = Atorvastatin, string = "Atorvastatin", onClick = msg (Atorvastatin) "Atorvastatin", tags = "" }
    , { value = AtovaquoneProguanil, string = "Atovaquone/Proguanil", onClick = msg (AtovaquoneProguanil) "Atovaquone/Proguanil", tags = "" }
    , { value = Atropine, string = "Atropine", onClick = msg (Atropine) "Atropine", tags = "" }
    , { value = Azathioprine, string = "Azathioprine", onClick = msg (Azathioprine) "Azathioprine", tags = "" }
    , { value = Benzatropine, string = "Benzatropine", onClick = msg (Benzatropine) "Benzatropine", tags = "" }
    , { value = Bupivacaine, string = "Bupivacaine", onClick = msg (Bupivacaine) "Bupivacaine", tags = "" }
    , { value = Calciumgluconate, string = "Calcium gluconate", onClick = msg (Calciumgluconate) "Calcium gluconate", tags = "" }
    , { value = Carbamazepine, string = "Carbamazepine", onClick = msg (Carbamazepine) "Carbamazepine", tags = "" }
    , { value = Carbimazole, string = "Carbimazole", onClick = msg (Carbimazole) "Carbimazole", tags = "" }
    , { value = Caspofungin, string = "Caspofungin", onClick = msg (Caspofungin) "Caspofungin", tags = "" }
    , { value = Cefalexin, string = "Cefalexin", onClick = msg (Cefalexin) "Cefalexin", tags = "" }
    , { value = Chlorpromazine, string = "Chlorpromazine", onClick = msg (Chlorpromazine) "Chlorpromazine", tags = "" }
    , { value = Ciclosporin, string = "Ciclosporin", onClick = msg (Ciclosporin) "Ciclosporin", tags = "" }
    , { value = Ciprofloxacin, string = "Ciprofloxacin", onClick = msg (Ciprofloxacin) "Ciprofloxacin", tags = "" }
    , { value = Clarithromycin, string = "Clarithromycin", onClick = msg (Clarithromycin) "Clarithromycin", tags = "" }
    , { value = Clomifene, string = "Clomifene ", onClick = msg (Clomifene) "Clomifene ", tags = "" }
    , { value = Clonazepam, string = "Clonazepam", onClick = msg (Clonazepam) "Clonazepam", tags = "" }
    , { value = Clopidogrel, string = "Clopidogrel", onClick = msg (Clopidogrel) "Clopidogrel", tags = "" }
    , { value = Clozapine, string = "Clozapine", onClick = msg (Clozapine) "Clozapine", tags = "" }
    , { value = Codeine, string = "Codeine", onClick = msg (Codeine) "Codeine", tags = "" }
    , { value = Colchicine, string = "Colchicine", onClick = msg (Colchicine) "Colchicine", tags = "" }
    , { value = Cromoglycate, string = "Cromoglycate", onClick = msg (Cromoglycate) "Cromoglycate", tags = "" }
    , { value = Cyclophosphamide, string = "Cyclophosphamide", onClick = msg (Cyclophosphamide) "Cyclophosphamide", tags = "" }
    , { value = Dabigatran, string = "Dabigatran", onClick = msg (Dabigatran) "Dabigatran", tags = "" }
    , { value = Denosumab, string = "Denosumab", onClick = msg (Denosumab) "Denosumab", tags = "" }
    , { value = Dexamethasone, string = "Dexamethasone", onClick = msg (Dexamethasone) "Dexamethasone", tags = "" }
    , { value = Dexamfetamine, string = "Dexamfetamine", onClick = msg (Dexamfetamine) "Dexamfetamine", tags = "" }
    , { value = Diazepam, string = "Diazepam", onClick = msg (Diazepam) "Diazepam", tags = "" }
    , { value = Diclofenac, string = "Diclofenac", onClick = msg (Diclofenac) "Diclofenac", tags = "" }
    , { value = Digoxin, string = "Digoxin", onClick = msg (Digoxin) "Digoxin", tags = "" }
    , { value = Digoxinspecificantibody, string = "Digoxin-specific antibody", onClick = msg (Digoxinspecificantibody) "Digoxin-specific antibody", tags = "" }
    , { value = Disulfiram, string = "Disulfiram", onClick = msg (Disulfiram) "Disulfiram", tags = "" }
    , { value = Docusate, string = "Docusate", onClick = msg (Docusate) "Docusate", tags = "" }
    , { value = Donepezil, string = "Donepezil", onClick = msg (Donepezil) "Donepezil", tags = "" }
    , { value = Doxorubicin, string = "Doxorubicin", onClick = msg (Doxorubicin) "Doxorubicin", tags = "" }
    , { value = Doxycycline, string = "Doxycycline", onClick = msg (Doxycycline) "Doxycycline", tags = "" }
    , { value = Enoxaparin, string = "Enoxaparin", onClick = msg (Enoxaparin) "Enoxaparin", tags = "" }
    , { value = Epoetinalfa, string = "Epoetin alfa", onClick = msg (Epoetinalfa) "Epoetin alfa", tags = "" }
    , { value = Erythromycin, string = "Erythromycin", onClick = msg (Erythromycin) "Erythromycin", tags = "" }
    , { value = Esomeprazole, string = "Esomeprazole", onClick = msg (Esomeprazole) "Esomeprazole", tags = "" }
    , { value = Ethinylestradiol, string = "Ethinylestradiol", onClick = msg (Ethinylestradiol) "Ethinylestradiol", tags = "" }
    , { value = Ethosuximide, string = "Ethosuximide", onClick = msg (Ethosuximide) "Ethosuximide", tags = "" }
    , { value = Exenatide, string = "Exenatide", onClick = msg (Exenatide) "Exenatide", tags = "" }
    , { value = Ezetimibe, string = "Ezetimibe", onClick = msg (Ezetimibe) "Ezetimibe", tags = "" }
    , { value = Fenofibrate, string = "Fenofibrate", onClick = msg (Fenofibrate) "Fenofibrate", tags = "" }
    , { value = Fentanyl, string = "Fentanyl", onClick = msg (Fentanyl) "Fentanyl", tags = "" }
    , { value = Finasteride, string = "Finasteride", onClick = msg (Finasteride) "Finasteride", tags = "" }
    , { value = Fluconazole, string = "Fluconazole", onClick = msg (Fluconazole) "Fluconazole", tags = "" }
    , { value = Fluorouracil, string = "Fluorouracil", onClick = msg (Fluorouracil) "Fluorouracil", tags = "" }
    , { value = Fluoxetine, string = "Fluoxetine", onClick = msg (Fluoxetine) "Fluoxetine", tags = "" }
    , { value = Fluticasone, string = "Fluticasone", onClick = msg (Fluticasone) "Fluticasone", tags = "" }
    , { value = Formoterol, string = "Formoterol", onClick = msg (Formoterol) "Formoterol", tags = "" }
    , { value = Furosemide, string = "Furosemide", onClick = msg (Furosemide) "Furosemide", tags = "" }
    , { value = Gentamicin, string = "Gentamicin", onClick = msg (Gentamicin) "Gentamicin", tags = "" }
    , { value = Gliclazide, string = "Gliclazide", onClick = msg (Gliclazide) "Gliclazide", tags = "" }
    , { value = Glucagon, string = "Glucagon", onClick = msg (Glucagon) "Glucagon", tags = "" }
    , { value = Glyceryltrinitrate, string = "Glyceryl trinitrate", onClick = msg (Glyceryltrinitrate) "Glyceryl trinitrate", tags = "" }
    , { value = Haloperidol, string = "Haloperidol", onClick = msg (Haloperidol) "Haloperidol", tags = "" }
    , { value = Heparin, string = "Heparin", onClick = msg (Heparin) "Heparin", tags = "" }
    , { value = Hydrochlorothiazide, string = "Hydrochlorothiazide", onClick = msg (Hydrochlorothiazide) "Hydrochlorothiazide", tags = "" }
    , { value = Hyoscine, string = "Hyoscine", onClick = msg (Hyoscine) "Hyoscine", tags = "" }
    , { value = Ibuprofen, string = "Ibuprofen", onClick = msg (Ibuprofen) "Ibuprofen", tags = "" }
    , { value = Imipramine, string = "Imipramine", onClick = msg (Imipramine) "Imipramine", tags = "" }
    , { value = Infliximab, string = "Infliximab", onClick = msg (Infliximab) "Infliximab", tags = "" }
    , { value = Insulin, string = "Insulin", onClick = msg (Insulin) "Insulin", tags = "" }
    , { value = Interferonalfa, string = "Interferon alfa", onClick = msg (Interferonalfa) "Interferon alfa", tags = "" }
    , { value = Ipratropium, string = "Ipratropium", onClick = msg (Ipratropium) "Ipratropium", tags = "" }
    , { value = Irbesartan, string = "Irbesartan", onClick = msg (Irbesartan) "Irbesartan", tags = "" }
    , { value = Isoniazid, string = "Isoniazid", onClick = msg (Isoniazid) "Isoniazid", tags = "" }
    , { value = Ivermectin, string = "Ivermectin", onClick = msg (Ivermectin) "Ivermectin", tags = "" }
    , { value = Ketamine, string = "Ketamine", onClick = msg (Ketamine) "Ketamine", tags = "" }
    , { value = Labetalol, string = "Labetalol", onClick = msg (Labetalol) "Labetalol", tags = "" }
    , { value = Lactulose, string = "Lactulose", onClick = msg (Lactulose) "Lactulose", tags = "" }
    , { value = Leflunomide, string = "Leflunomide", onClick = msg (Leflunomide) "Leflunomide", tags = "" }
    , { value = LevodopaCarbidopa, string = "Levodopa/Carbidopa", onClick = msg (LevodopaCarbidopa) "Levodopa/Carbidopa", tags = "" }
    , { value = Levonorgestrel, string = "Levonorgestrel", onClick = msg (Levonorgestrel) "Levonorgestrel", tags = "" }
    , { value = Levothyroxine, string = "Levothyroxine ", onClick = msg (Levothyroxine) "Levothyroxine ", tags = "" }
    , { value = Lidocaine, string = "Lidocaine", onClick = msg (Lidocaine) "Lidocaine", tags = "" }
    , { value = Lithium, string = "Lithium", onClick = msg (Lithium) "Lithium", tags = "" }
    , { value = Loperamide, string = "Loperamide", onClick = msg (Loperamide) "Loperamide", tags = "" }
    , { value = Loratadine, string = "Loratadine", onClick = msg (Loratadine) "Loratadine", tags = "" }
    , { value = Magnesiumsulfate, string = "Magnesium sulfate", onClick = msg (Magnesiumsulfate) "Magnesium sulfate", tags = "" }
    , { value = Meloxicam, string = "Meloxicam", onClick = msg (Meloxicam) "Meloxicam", tags = "" }
    , { value = Metformin, string = "Metformin", onClick = msg (Metformin) "Metformin", tags = "" }
    , { value = Methadone, string = "Methadone", onClick = msg (Methadone) "Methadone", tags = "" }
    , { value = Methotrexate, string = "Methotrexate", onClick = msg (Methotrexate) "Methotrexate", tags = "" }
    , { value = Methoxyflurane, string = "Methoxyflurane", onClick = msg (Methoxyflurane) "Methoxyflurane", tags = "" }
    , { value = Metoclopramide, string = "Metoclopramide", onClick = msg (Metoclopramide) "Metoclopramide", tags = "" }
    , { value = Metronidazole, string = "Metronidazole", onClick = msg (Metronidazole) "Metronidazole", tags = "" }
    , { value = Midazolam, string = "Midazolam", onClick = msg (Midazolam) "Midazolam", tags = "" }
    , { value = Mirtazapine, string = "Mirtazapine", onClick = msg (Mirtazapine) "Mirtazapine", tags = "" }
    , { value = Misoprostol, string = "Misoprostol", onClick = msg (Misoprostol) "Misoprostol", tags = "" }
    , { value = Moclobemide, string = "Moclobemide", onClick = msg (Moclobemide) "Moclobemide", tags = "" }
    , { value = Montelukast, string = "Montelukast", onClick = msg (Montelukast) "Montelukast", tags = "" }
    , { value = Morphine, string = "Morphine", onClick = msg (Morphine) "Morphine", tags = "" }
    , { value = Naloxone, string = "Naloxone", onClick = msg (Naloxone) "Naloxone", tags = "" }
    , { value = Nicotine, string = "Nicotine", onClick = msg (Nicotine) "Nicotine", tags = "" }
    , { value = Nifedipine, string = "Nifedipine", onClick = msg (Nifedipine) "Nifedipine", tags = "" }
    , { value = Nimodipine, string = "Nimodipine", onClick = msg (Nimodipine) "Nimodipine", tags = "" }
    , { value = Nitrousoxide, string = "Nitrous oxide", onClick = msg (Nitrousoxide) "Nitrous oxide", tags = "" }
    , { value = Olanzapine, string = "Olanzapine", onClick = msg (Olanzapine) "Olanzapine", tags = "" }
    , { value = Ondansetron, string = "Ondansetron", onClick = msg (Ondansetron) "Ondansetron", tags = "" }
    , { value = Orlistat, string = "Orlistat", onClick = msg (Orlistat) "Orlistat", tags = "" }
    , { value = Oseltamivir, string = "Oseltamivir", onClick = msg (Oseltamivir) "Oseltamivir", tags = "" }
    , { value = Oxybutynin, string = "Oxybutynin", onClick = msg (Oxybutynin) "Oxybutynin", tags = "" }
    , { value = Oxytocin, string = "Oxytocin", onClick = msg (Oxytocin) "Oxytocin", tags = "" }
    , { value = Paracetamol, string = "Paracetamol", onClick = msg (Paracetamol) "Paracetamol", tags = "" }
    , { value = Perindopril, string = "Perindopril", onClick = msg (Perindopril) "Perindopril", tags = "" }
    , { value = Phenytoin, string = "Phenytoin", onClick = msg (Phenytoin) "Phenytoin", tags = "" }
    , { value = Pramipexole, string = "Pramipexole", onClick = msg (Pramipexole) "Pramipexole", tags = "" }
    , { value = Prazosin, string = "Prazosin", onClick = msg (Prazosin) "Prazosin", tags = "" }
    , { value = Prednisolone, string = "Prednisolone", onClick = msg (Prednisolone) "Prednisolone", tags = "" }
    , { value = Prochlorperazine, string = "Prochlorperazine", onClick = msg (Prochlorperazine) "Prochlorperazine", tags = "" }
    , { value = Promethazine, string = "Promethazine", onClick = msg (Promethazine) "Promethazine", tags = "" }
    , { value = Propofol, string = "Propofol", onClick = msg (Propofol) "Propofol", tags = "" }
    , { value = Pyridostigmine, string = "Pyridostigmine", onClick = msg (Pyridostigmine) "Pyridostigmine", tags = "" }
    , { value = Quetiapine, string = "Quetiapine", onClick = msg (Quetiapine) "Quetiapine", tags = "" }
    , { value = Quinine, string = "Quinine", onClick = msg (Quinine) "Quinine", tags = "" }
    , { value = Ranitidine, string = "Ranitidine", onClick = msg (Ranitidine) "Ranitidine", tags = "" }
    , { value = Rifampicin, string = "Rifampicin", onClick = msg (Rifampicin) "Rifampicin", tags = "" }
    , { value = Risperidone, string = "Risperidone", onClick = msg (Risperidone) "Risperidone", tags = "" }
    , { value = Ritonavir, string = "Ritonavir", onClick = msg (Ritonavir) "Ritonavir", tags = "" }
    , { value = Rocuronium, string = "Rocuronium", onClick = msg (Rocuronium) "Rocuronium", tags = "" }
    , { value = Salbutamol, string = "Salbutamol", onClick = msg (Salbutamol) "Salbutamol", tags = "" }
    , { value = Selegiline, string = "Selegiline", onClick = msg (Selegiline) "Selegiline", tags = "" }
    , { value = Senna, string = "Senna", onClick = msg (Senna) "Senna", tags = "" }
    , { value = Sevoflurane, string = "Sevoflurane", onClick = msg (Sevoflurane) "Sevoflurane", tags = "" }
    , { value = Sildenafil, string = "Sildenafil", onClick = msg (Sildenafil) "Sildenafil", tags = "" }
    , { value = Sirolimus, string = "Sirolimus", onClick = msg (Sirolimus) "Sirolimus", tags = "" }
    , { value = Sitagliptin, string = "Sitagliptin", onClick = msg (Sitagliptin) "Sitagliptin", tags = "" }
    , { value = Somatropin, string = "Somatropin", onClick = msg (Somatropin) "Somatropin", tags = "" }
    , { value = Spironolactone, string = "Spironolactone", onClick = msg (Spironolactone) "Spironolactone", tags = "" }
    , { value = Sucralfate, string = "Sucralfate", onClick = msg (Sucralfate) "Sucralfate", tags = "" }
    , { value = Sulfasalazine, string = "Sulfasalazine", onClick = msg (Sulfasalazine) "Sulfasalazine", tags = "" }
    , { value = Suxamethonium, string = "Suxamethonium", onClick = msg (Suxamethonium) "Suxamethonium", tags = "" }
    , { value = Tamoxifen, string = "Tamoxifen", onClick = msg (Tamoxifen) "Tamoxifen", tags = "" }
    , { value = Tamsulosin, string = "Tamsulosin", onClick = msg (Tamsulosin) "Tamsulosin", tags = "" }
    , { value = Tenofoviremtricitabine, string = "Tenofovir/emtricitabine", onClick = msg (Tenofoviremtricitabine) "Tenofovir/emtricitabine", tags = "" }
    , { value = Testosterone, string = "Testosterone", onClick = msg (Testosterone) "Testosterone", tags = "" }
    , { value = Tetracaine, string = "Tetracaine", onClick = msg (Tetracaine) "Tetracaine", tags = "" }
    , { value = Thiopental, string = "Thiopental", onClick = msg (Thiopental) "Thiopental", tags = "" }
    , { value = Tramadol, string = "Tramadol", onClick = msg (Tramadol) "Tramadol", tags = "" }
    , { value = Trastuzumab, string = "Trastuzumab", onClick = msg (Trastuzumab) "Trastuzumab", tags = "" }
    , { value = Valproate, string = "Valproate", onClick = msg (Valproate) "Valproate", tags = "" }
    , { value = Vancomycin, string = "Vancomycin", onClick = msg (Vancomycin) "Vancomycin", tags = "" }
    , { value = Venlafaxine, string = "Venlafaxine", onClick = msg (Venlafaxine) "Venlafaxine", tags = "" }
    , { value = Verapamil, string = "Verapamil", onClick = msg (Verapamil) "Verapamil", tags = "" }
    , { value = Warfarin, string = "Warfarin ", onClick = msg (Warfarin) "Warfarin ", tags = "" }
    , { value = Zolpidem, string = "Zolpidem", onClick = msg (Zolpidem) "Zolpidem", tags = "" } ]



