module Diagnosis exposing (..)

import Option


type Diagnosis
    = Sicksinussyndrome
    | Bradyarrythmia
    | SupraventricularTachycardia
    | Ventriculartachycardia
    | AcutecoronarysyndromeMyocardialinfarction
    | Stableangina
    | Peripheralvasculardisease
    | Aorticaneurysm
    | Aorticdissection
    | Hypertension
    | Pulmonaryhypertension
    | Varicoseveinschronicvenousinsufficiency
    | Vascularinjury
    | Mitralstenosis
    | Aorticstenosis
    | Aorticregurgitation
    | Mitralregurgitation
    | Tricuspidstenosis
    | Tricuspidregurgitation
    | Pulmonicstenosis
    | Rheumaticfever
    | Infectiveendocarditis
    | Congestivecardiacfailure
    | Cardiomyopathy
    | Myocarditis
    | Acutepericarditis
    | Pericardialeffusion
    | Cardiactamponade
    | Asthma
    | COPD
    | Chronicbronchitis
    | Emphysema
    | Bronchiectasis
    | Cysticfibrosis
    | Pneumonia
    | Tuberculosis
    | Lungcancer
    | Pulmonaryfibrosis
    | Sarcoidosis
    | Ribfracture
    | Obstructivesleepapnoea
    | Pneumothorax
    | Pleuraleffusion
    | Empyema
    | Breastcancer
    | Breastfibroadenoma
    | Mastitis
    | GORD
    | Oesophagealcancer
    | Gastriccancer
    | Achalasia
    | Acutepancreatitis
    | Chronicpancreatitis
    | Pancreatictumour
    | Gastroenteritis
    | Acuteappendicitis
    | Acuteperitonitis
    | Bowelobstruction
    | Ischaemicbowel
    | Crohnsdisease
    | Ulcerativecolitis
    | Inflammatoryboweldisease
    | Colorectalcancer
    | Diverticulardisease
    | Abdominalhernia
    | Coeliacdisease
    | Irritablebowelsyndrome
    | GIST
    | Angiodysplasia
    | Haemorrhoids
    | Perianalfistula
    | Perianalabscess
    | Analfissure
    | Rectalprolapse
    | Analcancer
    | Abdominalinjury
    | HepatitisA
    | HepatitisB
    | HepatitisC
    | Hepaticabscess
    | Cirrhosis
    | Alcoholicliverdisease
    | NAFLD
    | Portalhypertension
    | Wilsonsdisease
    | Alpha1antitrypsindeficiency
    | Hepatocellularcarcinoma
    | Cholelithiasisgallstones
    | Cholecystitis
    | Acutekidneyinjury
    | Urinarytractinfection
    | Urolithiasiskidneystones
    | Nephroticsyndrome
    | Nephriticsyndrome
    | Pyelonephritis
    | Chronicrenalfailure
    | Diabetickidneydisease
    | Polycystickidneydisease
    | Glomerulonephritis
    | Renaltractcarcinoma
    | Bladdercancer
    | Benignprostatichypertrophy
    | Prostatecancer
    | Testiculartumour
    | Hydrocoele
    | Testiculartorsion
    | Epididymoorchitis
    | Type2diabetesmellitus
    | Type1diabetesmellitus
    | Hyperthyroidism
    | Hypothyroidism
    | Nontoxicthyroidnodule
    | Thyroidcancer
    | Cushingssyndrome
    | Addisonsdisease
    | Hyperaldosteronism
    | Phaeochromocytoma
    | Hypopituatarism
    | Pituiaryadenoma
    | Diabetesinsipidus
    | Pituiarycancer
    | Hyperparathyroidism
    | Hypoparathyroidism
    | Obestiy
    | Hyperlipidaemia
    | Osteoporosis
    | Osteomalacia
    | Migraine
    | Stroke
    | Intracranialhaemorrhage
    | Epilepsy
    | Braintumour
    | Meningioma
    | Glioblastoma
    | Meningitis
    | Bacterialmeningitis
    | Viralmeningitis
    | Encephalitis
    | Degenerativediscdisease
    | Spinalcordinjury
    | Myelitis
    | Peripheralneuropathy
    | Subduralhaemorrhage
    | Subarachnoidhaemorrhage
    | Epiduralhaematoma
    | Alzheimersdisease
    | Lewybodydementia
    | FrontotemporaldementiaPicksdisease
    | CreutzfeldtJakobdisease
    | Vasculardementia
    | Parkinsonsdisease
    | Carpaltunnelsyndrome
    | Multiplesclerosis
    | Tensionheadache
    | Clusterheadache
    | TemporalarteritisGiantcellarteritis
    | GuillainBarresyndrome
    | Motorneurondisease
    | Myastheniagravis
    | Myopathy
    | Osteoarthritis
    | Gout
    | Septicarthritis
    | Rheumatoidarthritis
    | Systemiclupuserythematosus
    | Scleroderma
    | Ankylosingspondylitis
    | Polymyalgiarheumatica
    | ANCAassociatedvasculitis
    | Skullfracture
    | Fractureofhumerus
    | Fractureofradius
    | Fractureofulna
    | Fractureoffemur
    | Fractureoftibia
    | Fractureoffibula
    | Fractureofscaphoid
    | Softtissueinjury
    | Irondeficiencyanaemia
    | VitaminB12deficiency
    | Folatedeficiency
    | Haemolyticanaemia
    | Aplasticanaemia
    | Sicklecelldisease
    | Hereditaryspherocytosis
    | G6PDdeficiency
    | AcutelymphoblasticleukaemiaALL
    | AcutemyeloidleukaemiaAML
    | ChroniclymphocyticleukaemiaCLL
    | ChronicmyeloidleukaemiaCML
    | Hodgkinlymphoma
    | Lymphoma
    | NonHodgkinlymphoma
    | Multiplemyeloma
    | VonWillebranddisease
    | HaemophiliaA
    | HaemophiliaB
    | Haemophilia
    | Deepveinthrombosis
    | Pulmonaryembolus
    | Myelofibrosis
    | Myelodysplasia
    | HIVAIDS
    | Influenza
    | EpsteinBarrvirusEBV
    | Denguefever
    | Cytomegalovirus
    | Typhoidfever
    | Malaria
    | Psoriasis
    | Eczema
    | Cellulitis
    | Abscess
    | HPV
    | Genitalwarts
    | Melanoma
    | SquamouscellcarcinomaSCC
    | Basalcellcarcinoma
    | Burns
    | Pressureulcer
    | Conjunctivitis
    | Blepharitis
    | Keratitis
    | Uveitis
    | Episcleritis
    | Cataract
    | Acuteangleclosureglaucoma
    | Chronicglaucoma
    | Retinaldetachment
    | Kawasakisdisease
    | TetralogyofFallot
    | TranspositionoftheGreatArteries
    | Patentductusarteriosus
    | Ventricularseptaldefect
    | Coarctationoftheaorta
    | Allergicrhinitis
    | Upperairwayobstruction
    | Anaphylaxis
    | Bronchiolitis
    | Croup
    | Osteomyelitis
    | Febrileconvulsions
    | Intusussception
    | Pyloricstenosis
    | Appendicitis
    | Childabuse
    | Domesticviolence
    | ImmunethrombocytopenicpurpuraITP
    | Idiopathicthrombocytopenia
    | HenochSchonleinpurpuraHSP
    | Thalassaemia
    | Autism
    | Downsyndrome
    | Seborrheicdermatitis
    | Measles
    | Rubella
    | Scabies
    | Varicellazoster
    | Menieresdisease
    | Presbycusis
    | Labyrinthitis
    | Otitismedia
    | Otitisexterna
    | Acnevulgaris
    | Acnerosacea
    | Hypoglycaemia
    | Suicideattempt
    | Chlamydia
    | Gonorrhoea
    | Bacterialvaginosis
    | Polycysticoveriansyndrome
    | Pelvicinflammatorydisease
    | Endometriosis
    | Endometritis
    | Miscarriage
    | Ectopicpregnancy
    | Pregnancy
    | Schizophrenia
    | Schizoaffectivedisorder
    | Delusionaldisorder
    | Bipolardisorder
    | Majordepressivedisorderdepression
    | Generalisedanxietydisorderanxiety
    | Panicdisorder
    | Agoraphobia
    | ObssessivecompulsivedisorderOCD
    | Anorexianervosa
    | Bulimianervosa
    | Schizoidpersonalitydisorder
    | Paranoidpersonalitydisorder
    | Borderlinepersonalitydisorder
    | Histrionicpersonalitydisorder
    | Narcissticpersonalitydisorder
    | Avoidantpersonalitydisorder
    | Schizotypalpersonalitydisorder
    | Antisocialpersonalitydisorder
    | Dependentpersonalitydisorder
    | Obsessivecompulsivepersonalitydisorder
    | Delirium
    | Somaticsymptomdisorder
    | Factitiousdisorder
    | Malingering
    | Autismspectrumdisorder
    | AttentiondeficithyperactivitydisorderADHD
    | Oppositionaldefiantdisorder
    | Conductdisorder
    | Substanceusedisorder


fromInt : Int -> Diagnosis
fromInt int =
    case int of
        0 ->
            Sicksinussyndrome

        1 ->
            Bradyarrythmia

        2 ->
            SupraventricularTachycardia

        3 ->
            Ventriculartachycardia

        4 ->
            AcutecoronarysyndromeMyocardialinfarction

        5 ->
            Stableangina

        6 ->
            Peripheralvasculardisease

        7 ->
            Aorticaneurysm

        8 ->
            Aorticdissection

        9 ->
            Hypertension

        10 ->
            Pulmonaryhypertension

        11 ->
            Varicoseveinschronicvenousinsufficiency

        12 ->
            Vascularinjury

        13 ->
            Mitralstenosis

        14 ->
            Aorticstenosis

        15 ->
            Aorticregurgitation

        16 ->
            Mitralregurgitation

        17 ->
            Tricuspidstenosis

        18 ->
            Tricuspidregurgitation

        19 ->
            Pulmonicstenosis

        20 ->
            Rheumaticfever

        21 ->
            Infectiveendocarditis

        22 ->
            Congestivecardiacfailure

        23 ->
            Cardiomyopathy

        24 ->
            Myocarditis

        25 ->
            Acutepericarditis

        26 ->
            Pericardialeffusion

        27 ->
            Cardiactamponade

        28 ->
            Asthma

        29 ->
            COPD

        30 ->
            Chronicbronchitis

        31 ->
            Emphysema

        32 ->
            Bronchiectasis

        33 ->
            Cysticfibrosis

        34 ->
            Pneumonia

        35 ->
            Tuberculosis

        36 ->
            Lungcancer

        37 ->
            Pulmonaryfibrosis

        38 ->
            Sarcoidosis

        39 ->
            Ribfracture

        40 ->
            Obstructivesleepapnoea

        41 ->
            Pneumothorax

        42 ->
            Pleuraleffusion

        43 ->
            Empyema

        44 ->
            Breastcancer

        45 ->
            Breastfibroadenoma

        46 ->
            Mastitis

        47 ->
            GORD

        48 ->
            Oesophagealcancer

        49 ->
            Gastriccancer

        50 ->
            Achalasia

        51 ->
            Acutepancreatitis

        52 ->
            Chronicpancreatitis

        53 ->
            Pancreatictumour

        54 ->
            Gastroenteritis

        55 ->
            Acuteappendicitis

        56 ->
            Acuteperitonitis

        57 ->
            Bowelobstruction

        58 ->
            Ischaemicbowel

        59 ->
            Crohnsdisease

        60 ->
            Ulcerativecolitis

        61 ->
            Inflammatoryboweldisease

        62 ->
            Colorectalcancer

        63 ->
            Diverticulardisease

        64 ->
            Abdominalhernia

        65 ->
            Coeliacdisease

        66 ->
            Irritablebowelsyndrome

        67 ->
            GIST

        68 ->
            Angiodysplasia

        69 ->
            Haemorrhoids

        70 ->
            Perianalfistula

        71 ->
            Perianalabscess

        72 ->
            Analfissure

        73 ->
            Rectalprolapse

        74 ->
            Analcancer

        75 ->
            Abdominalinjury

        76 ->
            HepatitisA

        77 ->
            HepatitisB

        78 ->
            HepatitisC

        79 ->
            Hepaticabscess

        80 ->
            Cirrhosis

        81 ->
            Alcoholicliverdisease

        82 ->
            NAFLD

        83 ->
            Portalhypertension

        84 ->
            Wilsonsdisease

        85 ->
            Alpha1antitrypsindeficiency

        86 ->
            Hepatocellularcarcinoma

        87 ->
            Cholelithiasisgallstones

        88 ->
            Cholecystitis

        89 ->
            Acutekidneyinjury

        90 ->
            Urinarytractinfection

        91 ->
            Urolithiasiskidneystones

        92 ->
            Nephroticsyndrome

        93 ->
            Nephriticsyndrome

        94 ->
            Pyelonephritis

        95 ->
            Chronicrenalfailure

        96 ->
            Diabetickidneydisease

        97 ->
            Polycystickidneydisease

        98 ->
            Glomerulonephritis

        99 ->
            Renaltractcarcinoma

        100 ->
            Bladdercancer

        101 ->
            Benignprostatichypertrophy

        102 ->
            Prostatecancer

        103 ->
            Testiculartumour

        104 ->
            Hydrocoele

        105 ->
            Testiculartorsion

        106 ->
            Epididymoorchitis

        107 ->
            Type2diabetesmellitus

        108 ->
            Type1diabetesmellitus

        109 ->
            Hyperthyroidism

        110 ->
            Hypothyroidism

        111 ->
            Nontoxicthyroidnodule

        112 ->
            Thyroidcancer

        113 ->
            Cushingssyndrome

        114 ->
            Addisonsdisease

        115 ->
            Hyperaldosteronism

        116 ->
            Phaeochromocytoma

        117 ->
            Hypopituatarism

        118 ->
            Pituiaryadenoma

        119 ->
            Diabetesinsipidus

        120 ->
            Pituiarycancer

        121 ->
            Hyperparathyroidism

        122 ->
            Hypoparathyroidism

        123 ->
            Obestiy

        124 ->
            Hyperlipidaemia

        125 ->
            Osteoporosis

        126 ->
            Osteomalacia

        127 ->
            Migraine

        128 ->
            Stroke

        129 ->
            Intracranialhaemorrhage

        130 ->
            Epilepsy

        131 ->
            Braintumour

        132 ->
            Meningioma

        133 ->
            Glioblastoma

        134 ->
            Meningitis

        135 ->
            Bacterialmeningitis

        136 ->
            Viralmeningitis

        137 ->
            Encephalitis

        138 ->
            Degenerativediscdisease

        139 ->
            Spinalcordinjury

        140 ->
            Myelitis

        141 ->
            Peripheralneuropathy

        142 ->
            Subduralhaemorrhage

        143 ->
            Subarachnoidhaemorrhage

        144 ->
            Epiduralhaematoma

        145 ->
            Alzheimersdisease

        146 ->
            Lewybodydementia

        147 ->
            FrontotemporaldementiaPicksdisease

        148 ->
            CreutzfeldtJakobdisease

        149 ->
            Vasculardementia

        150 ->
            Parkinsonsdisease

        151 ->
            Carpaltunnelsyndrome

        152 ->
            Multiplesclerosis

        153 ->
            Tensionheadache

        154 ->
            Clusterheadache

        155 ->
            TemporalarteritisGiantcellarteritis

        156 ->
            GuillainBarresyndrome

        157 ->
            Motorneurondisease

        158 ->
            Myastheniagravis

        159 ->
            Myopathy

        160 ->
            Osteoarthritis

        161 ->
            Gout

        162 ->
            Septicarthritis

        163 ->
            Rheumatoidarthritis

        164 ->
            Systemiclupuserythematosus

        165 ->
            Scleroderma

        166 ->
            Ankylosingspondylitis

        167 ->
            Polymyalgiarheumatica

        168 ->
            ANCAassociatedvasculitis

        169 ->
            Skullfracture

        170 ->
            Fractureofhumerus

        171 ->
            Fractureofradius

        172 ->
            Fractureofulna

        173 ->
            Fractureoffemur

        174 ->
            Fractureoftibia

        175 ->
            Fractureoffibula

        176 ->
            Fractureofscaphoid

        177 ->
            Softtissueinjury

        178 ->
            Irondeficiencyanaemia

        179 ->
            VitaminB12deficiency

        180 ->
            Folatedeficiency

        181 ->
            Haemolyticanaemia

        182 ->
            Aplasticanaemia

        183 ->
            Sicklecelldisease

        184 ->
            Hereditaryspherocytosis

        185 ->
            G6PDdeficiency

        186 ->
            AcutelymphoblasticleukaemiaALL

        187 ->
            AcutemyeloidleukaemiaAML

        188 ->
            ChroniclymphocyticleukaemiaCLL

        189 ->
            ChronicmyeloidleukaemiaCML

        190 ->
            Hodgkinlymphoma

        191 ->
            Lymphoma

        192 ->
            NonHodgkinlymphoma

        193 ->
            Multiplemyeloma

        194 ->
            VonWillebranddisease

        195 ->
            HaemophiliaA

        196 ->
            HaemophiliaB

        197 ->
            Haemophilia

        198 ->
            Deepveinthrombosis

        199 ->
            Pulmonaryembolus

        200 ->
            Myelofibrosis

        201 ->
            Myelodysplasia

        202 ->
            HIVAIDS

        203 ->
            Influenza

        204 ->
            EpsteinBarrvirusEBV

        205 ->
            Denguefever

        206 ->
            Cytomegalovirus

        207 ->
            Typhoidfever

        208 ->
            Malaria

        209 ->
            Psoriasis

        210 ->
            Eczema

        211 ->
            Cellulitis

        212 ->
            Abscess

        213 ->
            HPV

        214 ->
            Genitalwarts

        215 ->
            Melanoma

        216 ->
            SquamouscellcarcinomaSCC

        217 ->
            Basalcellcarcinoma

        218 ->
            Burns

        219 ->
            Pressureulcer

        220 ->
            Conjunctivitis

        221 ->
            Blepharitis

        222 ->
            Keratitis

        223 ->
            Uveitis

        224 ->
            Episcleritis

        225 ->
            Cataract

        226 ->
            Acuteangleclosureglaucoma

        227 ->
            Chronicglaucoma

        228 ->
            Retinaldetachment

        229 ->
            Kawasakisdisease

        230 ->
            TetralogyofFallot

        231 ->
            TranspositionoftheGreatArteries

        232 ->
            Patentductusarteriosus

        233 ->
            Ventricularseptaldefect

        234 ->
            Coarctationoftheaorta

        235 ->
            Allergicrhinitis

        236 ->
            Upperairwayobstruction

        237 ->
            Anaphylaxis

        238 ->
            Bronchiolitis

        239 ->
            Croup

        240 ->
            Osteomyelitis

        241 ->
            Febrileconvulsions

        242 ->
            Intusussception

        243 ->
            Pyloricstenosis

        244 ->
            Appendicitis

        245 ->
            Childabuse

        246 ->
            Domesticviolence

        247 ->
            ImmunethrombocytopenicpurpuraITP

        248 ->
            Idiopathicthrombocytopenia

        249 ->
            HenochSchonleinpurpuraHSP

        250 ->
            Thalassaemia

        251 ->
            Autism

        252 ->
            Downsyndrome

        253 ->
            Seborrheicdermatitis

        254 ->
            Measles

        255 ->
            Rubella

        256 ->
            Scabies

        257 ->
            Varicellazoster

        258 ->
            Menieresdisease

        259 ->
            Presbycusis

        260 ->
            Labyrinthitis

        261 ->
            Otitismedia

        262 ->
            Otitisexterna

        263 ->
            Acnevulgaris

        264 ->
            Acnerosacea

        265 ->
            Hypoglycaemia

        266 ->
            Suicideattempt

        267 ->
            Chlamydia

        268 ->
            Gonorrhoea

        269 ->
            Bacterialvaginosis

        270 ->
            Polycysticoveriansyndrome

        271 ->
            Pelvicinflammatorydisease

        272 ->
            Endometriosis

        273 ->
            Endometritis

        274 ->
            Miscarriage

        275 ->
            Ectopicpregnancy

        276 ->
            Pregnancy

        277 ->
            Schizophrenia

        278 ->
            Schizoaffectivedisorder

        279 ->
            Delusionaldisorder

        280 ->
            Bipolardisorder

        281 ->
            Majordepressivedisorderdepression

        282 ->
            Generalisedanxietydisorderanxiety

        283 ->
            Panicdisorder

        284 ->
            Agoraphobia

        285 ->
            ObssessivecompulsivedisorderOCD

        286 ->
            Anorexianervosa

        287 ->
            Bulimianervosa

        288 ->
            Schizoidpersonalitydisorder

        289 ->
            Paranoidpersonalitydisorder

        290 ->
            Borderlinepersonalitydisorder

        291 ->
            Histrionicpersonalitydisorder

        292 ->
            Narcissticpersonalitydisorder

        293 ->
            Avoidantpersonalitydisorder

        294 ->
            Schizotypalpersonalitydisorder

        295 ->
            Antisocialpersonalitydisorder

        296 ->
            Dependentpersonalitydisorder

        297 ->
            Obsessivecompulsivepersonalitydisorder

        298 ->
            Delirium

        299 ->
            Somaticsymptomdisorder

        300 ->
            Factitiousdisorder

        301 ->
            Malingering

        302 ->
            Autismspectrumdisorder

        303 ->
            AttentiondeficithyperactivitydisorderADHD

        304 ->
            Oppositionaldefiantdisorder

        305 ->
            Conductdisorder

        306 ->
            Substanceusedisorder

        _ ->
            Sicksinussyndrome


toInt : Diagnosis -> Int
toInt enum =
    case enum of
        Sicksinussyndrome ->
            0

        Bradyarrythmia ->
            1

        SupraventricularTachycardia ->
            2

        Ventriculartachycardia ->
            3

        AcutecoronarysyndromeMyocardialinfarction ->
            4

        Stableangina ->
            5

        Peripheralvasculardisease ->
            6

        Aorticaneurysm ->
            7

        Aorticdissection ->
            8

        Hypertension ->
            9

        Pulmonaryhypertension ->
            10

        Varicoseveinschronicvenousinsufficiency ->
            11

        Vascularinjury ->
            12

        Mitralstenosis ->
            13

        Aorticstenosis ->
            14

        Aorticregurgitation ->
            15

        Mitralregurgitation ->
            16

        Tricuspidstenosis ->
            17

        Tricuspidregurgitation ->
            18

        Pulmonicstenosis ->
            19

        Rheumaticfever ->
            20

        Infectiveendocarditis ->
            21

        Congestivecardiacfailure ->
            22

        Cardiomyopathy ->
            23

        Myocarditis ->
            24

        Acutepericarditis ->
            25

        Pericardialeffusion ->
            26

        Cardiactamponade ->
            27

        Asthma ->
            28

        COPD ->
            29

        Chronicbronchitis ->
            30

        Emphysema ->
            31

        Bronchiectasis ->
            32

        Cysticfibrosis ->
            33

        Pneumonia ->
            34

        Tuberculosis ->
            35

        Lungcancer ->
            36

        Pulmonaryfibrosis ->
            37

        Sarcoidosis ->
            38

        Ribfracture ->
            39

        Obstructivesleepapnoea ->
            40

        Pneumothorax ->
            41

        Pleuraleffusion ->
            42

        Empyema ->
            43

        Breastcancer ->
            44

        Breastfibroadenoma ->
            45

        Mastitis ->
            46

        GORD ->
            47

        Oesophagealcancer ->
            48

        Gastriccancer ->
            49

        Achalasia ->
            50

        Acutepancreatitis ->
            51

        Chronicpancreatitis ->
            52

        Pancreatictumour ->
            53

        Gastroenteritis ->
            54

        Acuteappendicitis ->
            55

        Acuteperitonitis ->
            56

        Bowelobstruction ->
            57

        Ischaemicbowel ->
            58

        Crohnsdisease ->
            59

        Ulcerativecolitis ->
            60

        Inflammatoryboweldisease ->
            61

        Colorectalcancer ->
            62

        Diverticulardisease ->
            63

        Abdominalhernia ->
            64

        Coeliacdisease ->
            65

        Irritablebowelsyndrome ->
            66

        GIST ->
            67

        Angiodysplasia ->
            68

        Haemorrhoids ->
            69

        Perianalfistula ->
            70

        Perianalabscess ->
            71

        Analfissure ->
            72

        Rectalprolapse ->
            73

        Analcancer ->
            74

        Abdominalinjury ->
            75

        HepatitisA ->
            76

        HepatitisB ->
            77

        HepatitisC ->
            78

        Hepaticabscess ->
            79

        Cirrhosis ->
            80

        Alcoholicliverdisease ->
            81

        NAFLD ->
            82

        Portalhypertension ->
            83

        Wilsonsdisease ->
            84

        Alpha1antitrypsindeficiency ->
            85

        Hepatocellularcarcinoma ->
            86

        Cholelithiasisgallstones ->
            87

        Cholecystitis ->
            88

        Acutekidneyinjury ->
            89

        Urinarytractinfection ->
            90

        Urolithiasiskidneystones ->
            91

        Nephroticsyndrome ->
            92

        Nephriticsyndrome ->
            93

        Pyelonephritis ->
            94

        Chronicrenalfailure ->
            95

        Diabetickidneydisease ->
            96

        Polycystickidneydisease ->
            97

        Glomerulonephritis ->
            98

        Renaltractcarcinoma ->
            99

        Bladdercancer ->
            100

        Benignprostatichypertrophy ->
            101

        Prostatecancer ->
            102

        Testiculartumour ->
            103

        Hydrocoele ->
            104

        Testiculartorsion ->
            105

        Epididymoorchitis ->
            106

        Type2diabetesmellitus ->
            107

        Type1diabetesmellitus ->
            108

        Hyperthyroidism ->
            109

        Hypothyroidism ->
            110

        Nontoxicthyroidnodule ->
            111

        Thyroidcancer ->
            112

        Cushingssyndrome ->
            113

        Addisonsdisease ->
            114

        Hyperaldosteronism ->
            115

        Phaeochromocytoma ->
            116

        Hypopituatarism ->
            117

        Pituiaryadenoma ->
            118

        Diabetesinsipidus ->
            119

        Pituiarycancer ->
            120

        Hyperparathyroidism ->
            121

        Hypoparathyroidism ->
            122

        Obestiy ->
            123

        Hyperlipidaemia ->
            124

        Osteoporosis ->
            125

        Osteomalacia ->
            126

        Migraine ->
            127

        Stroke ->
            128

        Intracranialhaemorrhage ->
            129

        Epilepsy ->
            130

        Braintumour ->
            131

        Meningioma ->
            132

        Glioblastoma ->
            133

        Meningitis ->
            134

        Bacterialmeningitis ->
            135

        Viralmeningitis ->
            136

        Encephalitis ->
            137

        Degenerativediscdisease ->
            138

        Spinalcordinjury ->
            139

        Myelitis ->
            140

        Peripheralneuropathy ->
            141

        Subduralhaemorrhage ->
            142

        Subarachnoidhaemorrhage ->
            143

        Epiduralhaematoma ->
            144

        Alzheimersdisease ->
            145

        Lewybodydementia ->
            146

        FrontotemporaldementiaPicksdisease ->
            147

        CreutzfeldtJakobdisease ->
            148

        Vasculardementia ->
            149

        Parkinsonsdisease ->
            150

        Carpaltunnelsyndrome ->
            151

        Multiplesclerosis ->
            152

        Tensionheadache ->
            153

        Clusterheadache ->
            154

        TemporalarteritisGiantcellarteritis ->
            155

        GuillainBarresyndrome ->
            156

        Motorneurondisease ->
            157

        Myastheniagravis ->
            158

        Myopathy ->
            159

        Osteoarthritis ->
            160

        Gout ->
            161

        Septicarthritis ->
            162

        Rheumatoidarthritis ->
            163

        Systemiclupuserythematosus ->
            164

        Scleroderma ->
            165

        Ankylosingspondylitis ->
            166

        Polymyalgiarheumatica ->
            167

        ANCAassociatedvasculitis ->
            168

        Skullfracture ->
            169

        Fractureofhumerus ->
            170

        Fractureofradius ->
            171

        Fractureofulna ->
            172

        Fractureoffemur ->
            173

        Fractureoftibia ->
            174

        Fractureoffibula ->
            175

        Fractureofscaphoid ->
            176

        Softtissueinjury ->
            177

        Irondeficiencyanaemia ->
            178

        VitaminB12deficiency ->
            179

        Folatedeficiency ->
            180

        Haemolyticanaemia ->
            181

        Aplasticanaemia ->
            182

        Sicklecelldisease ->
            183

        Hereditaryspherocytosis ->
            184

        G6PDdeficiency ->
            185

        AcutelymphoblasticleukaemiaALL ->
            186

        AcutemyeloidleukaemiaAML ->
            187

        ChroniclymphocyticleukaemiaCLL ->
            188

        ChronicmyeloidleukaemiaCML ->
            189

        Hodgkinlymphoma ->
            190

        Lymphoma ->
            191

        NonHodgkinlymphoma ->
            192

        Multiplemyeloma ->
            193

        VonWillebranddisease ->
            194

        HaemophiliaA ->
            195

        HaemophiliaB ->
            196

        Haemophilia ->
            197

        Deepveinthrombosis ->
            198

        Pulmonaryembolus ->
            199

        Myelofibrosis ->
            200

        Myelodysplasia ->
            201

        HIVAIDS ->
            202

        Influenza ->
            203

        EpsteinBarrvirusEBV ->
            204

        Denguefever ->
            205

        Cytomegalovirus ->
            206

        Typhoidfever ->
            207

        Malaria ->
            208

        Psoriasis ->
            209

        Eczema ->
            210

        Cellulitis ->
            211

        Abscess ->
            212

        HPV ->
            213

        Genitalwarts ->
            214

        Melanoma ->
            215

        SquamouscellcarcinomaSCC ->
            216

        Basalcellcarcinoma ->
            217

        Burns ->
            218

        Pressureulcer ->
            219

        Conjunctivitis ->
            220

        Blepharitis ->
            221

        Keratitis ->
            222

        Uveitis ->
            223

        Episcleritis ->
            224

        Cataract ->
            225

        Acuteangleclosureglaucoma ->
            226

        Chronicglaucoma ->
            227

        Retinaldetachment ->
            228

        Kawasakisdisease ->
            229

        TetralogyofFallot ->
            230

        TranspositionoftheGreatArteries ->
            231

        Patentductusarteriosus ->
            232

        Ventricularseptaldefect ->
            233

        Coarctationoftheaorta ->
            234

        Allergicrhinitis ->
            235

        Upperairwayobstruction ->
            236

        Anaphylaxis ->
            237

        Bronchiolitis ->
            238

        Croup ->
            239

        Osteomyelitis ->
            240

        Febrileconvulsions ->
            241

        Intusussception ->
            242

        Pyloricstenosis ->
            243

        Appendicitis ->
            244

        Childabuse ->
            245

        Domesticviolence ->
            246

        ImmunethrombocytopenicpurpuraITP ->
            247

        Idiopathicthrombocytopenia ->
            248

        HenochSchonleinpurpuraHSP ->
            249

        Thalassaemia ->
            250

        Autism ->
            251

        Downsyndrome ->
            252

        Seborrheicdermatitis ->
            253

        Measles ->
            254

        Rubella ->
            255

        Scabies ->
            256

        Varicellazoster ->
            257

        Menieresdisease ->
            258

        Presbycusis ->
            259

        Labyrinthitis ->
            260

        Otitismedia ->
            261

        Otitisexterna ->
            262

        Acnevulgaris ->
            263

        Acnerosacea ->
            264

        Hypoglycaemia ->
            265

        Suicideattempt ->
            266

        Chlamydia ->
            267

        Gonorrhoea ->
            268

        Bacterialvaginosis ->
            269

        Polycysticoveriansyndrome ->
            270

        Pelvicinflammatorydisease ->
            271

        Endometriosis ->
            272

        Endometritis ->
            273

        Miscarriage ->
            274

        Ectopicpregnancy ->
            275

        Pregnancy ->
            276

        Schizophrenia ->
            277

        Schizoaffectivedisorder ->
            278

        Delusionaldisorder ->
            279

        Bipolardisorder ->
            280

        Majordepressivedisorderdepression ->
            281

        Generalisedanxietydisorderanxiety ->
            282

        Panicdisorder ->
            283

        Agoraphobia ->
            284

        ObssessivecompulsivedisorderOCD ->
            285

        Anorexianervosa ->
            286

        Bulimianervosa ->
            287

        Schizoidpersonalitydisorder ->
            288

        Paranoidpersonalitydisorder ->
            289

        Borderlinepersonalitydisorder ->
            290

        Histrionicpersonalitydisorder ->
            291

        Narcissticpersonalitydisorder ->
            292

        Avoidantpersonalitydisorder ->
            293

        Schizotypalpersonalitydisorder ->
            294

        Antisocialpersonalitydisorder ->
            295

        Dependentpersonalitydisorder ->
            296

        Obsessivecompulsivepersonalitydisorder ->
            297

        Delirium ->
            298

        Somaticsymptomdisorder ->
            299

        Factitiousdisorder ->
            300

        Malingering ->
            301

        Autismspectrumdisorder ->
            302

        AttentiondeficithyperactivitydisorderADHD ->
            303

        Oppositionaldefiantdisorder ->
            304

        Conductdisorder ->
            305

        Substanceusedisorder ->
            306


toString : Diagnosis -> String
toString enum =
    case enum of
        Sicksinussyndrome ->
            "Sick sinus syndrome"

        Bradyarrythmia ->
            "Bradyarrythmia"

        SupraventricularTachycardia ->
            "Supraventricular Tachycardia"

        Ventriculartachycardia ->
            "Ventricular tachycardia"

        AcutecoronarysyndromeMyocardialinfarction ->
            "Acute coronary syndrome / Myocardial infarction"

        Stableangina ->
            "Stable angina"

        Peripheralvasculardisease ->
            "Peripheral vascular disease"

        Aorticaneurysm ->
            "Aortic aneurysm"

        Aorticdissection ->
            "Aortic dissection"

        Hypertension ->
            "Hypertension"

        Pulmonaryhypertension ->
            "Pulmonary hypertension"

        Varicoseveinschronicvenousinsufficiency ->
            "Varicose veins / chronic venous insufficiency"

        Vascularinjury ->
            "Vascular injury"

        Mitralstenosis ->
            "Mitral stenosis"

        Aorticstenosis ->
            "Aortic stenosis"

        Aorticregurgitation ->
            "Aortic regurgitation"

        Mitralregurgitation ->
            "Mitral regurgitation"

        Tricuspidstenosis ->
            "Tricuspid stenosis"

        Tricuspidregurgitation ->
            "Tricuspid regurgitation"

        Pulmonicstenosis ->
            "Pulmonic stenosis"

        Rheumaticfever ->
            "Rheumatic fever"

        Infectiveendocarditis ->
            "Infective endocarditis"

        Congestivecardiacfailure ->
            "Congestive cardiac failure"

        Cardiomyopathy ->
            "Cardiomyopathy"

        Myocarditis ->
            "Myocarditis"

        Acutepericarditis ->
            "Acute pericarditis"

        Pericardialeffusion ->
            "Pericardial effusion"

        Cardiactamponade ->
            "Cardiac tamponade"

        Asthma ->
            "Asthma"

        COPD ->
            "COPD"

        Chronicbronchitis ->
            "Chronic bronchitis"

        Emphysema ->
            "Emphysema"

        Bronchiectasis ->
            "Bronchiectasis"

        Cysticfibrosis ->
            "Cystic fibrosis"

        Pneumonia ->
            "Pneumonia"

        Tuberculosis ->
            "Tuberculosis"

        Lungcancer ->
            "Lung cancer"

        Pulmonaryfibrosis ->
            "Pulmonary fibrosis"

        Sarcoidosis ->
            "Sarcoidosis"

        Ribfracture ->
            "Rib fracture"

        Obstructivesleepapnoea ->
            "Obstructive sleep apnoea"

        Pneumothorax ->
            "Pneumothorax"

        Pleuraleffusion ->
            "Pleural effusion"

        Empyema ->
            "Empyema"

        Breastcancer ->
            "Breast cancer"

        Breastfibroadenoma ->
            "Breast fibroadenoma"

        Mastitis ->
            "Mastitis"

        GORD ->
            "GORD"

        Oesophagealcancer ->
            "Oesophageal cancer"

        Gastriccancer ->
            "Gastric cancer"

        Achalasia ->
            "Achalasia"

        Acutepancreatitis ->
            "Acute pancreatitis"

        Chronicpancreatitis ->
            "Chronic pancreatitis"

        Pancreatictumour ->
            "Pancreatic tumour"

        Gastroenteritis ->
            "Gastroenteritis"

        Acuteappendicitis ->
            "Acute appendicitis"

        Acuteperitonitis ->
            "Acute peritonitis"

        Bowelobstruction ->
            "Bowel obstruction"

        Ischaemicbowel ->
            "Ischaemic bowel"

        Crohnsdisease ->
            "Crohn's disease"

        Ulcerativecolitis ->
            "Ulcerative colitis"

        Inflammatoryboweldisease ->
            "Inflammatory bowel disease"

        Colorectalcancer ->
            "Colorectal cancer"

        Diverticulardisease ->
            "Diverticular disease"

        Abdominalhernia ->
            "Abdominal hernia"

        Coeliacdisease ->
            "Coeliac disease"

        Irritablebowelsyndrome ->
            "Irritable bowel syndrome"

        GIST ->
            "GIST"

        Angiodysplasia ->
            "Angiodysplasia"

        Haemorrhoids ->
            "Haemorrhoids"

        Perianalfistula ->
            "Perianal fistula"

        Perianalabscess ->
            "Perianal abscess"

        Analfissure ->
            "Anal fissure"

        Rectalprolapse ->
            "Rectal prolapse"

        Analcancer ->
            "Anal cancer"

        Abdominalinjury ->
            "Abdominal injury"

        HepatitisA ->
            "Hepatitis A"

        HepatitisB ->
            "Hepatitis B"

        HepatitisC ->
            "Hepatitis C"

        Hepaticabscess ->
            "Hepatic abscess"

        Cirrhosis ->
            "Cirrhosis"

        Alcoholicliverdisease ->
            "Alcoholic liver disease"

        NAFLD ->
            "NAFLD"

        Portalhypertension ->
            "Portal hypertension"

        Wilsonsdisease ->
            "Wilson's disease"

        Alpha1antitrypsindeficiency ->
            "Alpha-1 antitrypsin deficiency"

        Hepatocellularcarcinoma ->
            "Hepatocellular carcinoma"

        Cholelithiasisgallstones ->
            "Cholelithiasis / gallstones"

        Cholecystitis ->
            "Cholecystitis"

        Acutekidneyinjury ->
            "Acute kidney injury"

        Urinarytractinfection ->
            "Urinary tract infection"

        Urolithiasiskidneystones ->
            "Urolithiasis / kidney stones"

        Nephroticsyndrome ->
            "Nephrotic syndrome"

        Nephriticsyndrome ->
            "Nephritic syndrome"

        Pyelonephritis ->
            "Pyelonephritis"

        Chronicrenalfailure ->
            "Chronic renal failure"

        Diabetickidneydisease ->
            "Diabetic kidney disease"

        Polycystickidneydisease ->
            "Polycystic kidney disease"

        Glomerulonephritis ->
            "Glomerulonephritis"

        Renaltractcarcinoma ->
            "Renal tract carcinoma"

        Bladdercancer ->
            "Bladder cancer"

        Benignprostatichypertrophy ->
            "Benign prostatic hypertrophy"

        Prostatecancer ->
            "Prostate cancer"

        Testiculartumour ->
            "Testicular tumour"

        Hydrocoele ->
            "Hydrocoele"

        Testiculartorsion ->
            "Testicular torsion"

        Epididymoorchitis ->
            "Epididymoorchitis"

        Type2diabetesmellitus ->
            "Type 2 diabetes mellitus"

        Type1diabetesmellitus ->
            "Type 1 diabetes mellitus"

        Hyperthyroidism ->
            "Hyperthyroidism"

        Hypothyroidism ->
            "Hypothyroidism"

        Nontoxicthyroidnodule ->
            "Non-toxic thyroid nodule"

        Thyroidcancer ->
            "Thyroid cancer"

        Cushingssyndrome ->
            "Cushing's syndrome"

        Addisonsdisease ->
            "Addison's disease"

        Hyperaldosteronism ->
            "Hyperaldosteronism"

        Phaeochromocytoma ->
            "Phaeochromocytoma"

        Hypopituatarism ->
            "Hypopituatarism"

        Pituiaryadenoma ->
            "Pituiary adenoma"

        Diabetesinsipidus ->
            "Diabetes insipidus"

        Pituiarycancer ->
            "Pituiary cancer"

        Hyperparathyroidism ->
            "Hyperparathyroidism"

        Hypoparathyroidism ->
            "Hypoparathyroidism"

        Obestiy ->
            "Obestiy"

        Hyperlipidaemia ->
            "Hyperlipidaemia"

        Osteoporosis ->
            "Osteoporosis"

        Osteomalacia ->
            "Osteomalacia"

        Migraine ->
            "Migraine"

        Stroke ->
            "Stroke"

        Intracranialhaemorrhage ->
            "intracranial haemorrhage"

        Epilepsy ->
            "Epilepsy"

        Braintumour ->
            "Brain tumour"

        Meningioma ->
            "Meningioma"

        Glioblastoma ->
            "Glioblastoma"

        Meningitis ->
            "Meningitis"

        Bacterialmeningitis ->
            "Bacterial meningitis"

        Viralmeningitis ->
            "Viral meningitis"

        Encephalitis ->
            "Encephalitis"

        Degenerativediscdisease ->
            "Degenerative disc disease"

        Spinalcordinjury ->
            "Spinal cord injury"

        Myelitis ->
            "Myelitis"

        Peripheralneuropathy ->
            "Peripheral neuropathy"

        Subduralhaemorrhage ->
            "Subdural haemorrhage"

        Subarachnoidhaemorrhage ->
            "Subarachnoid haemorrhage"

        Epiduralhaematoma ->
            "Epidural haematoma"

        Alzheimersdisease ->
            "Alzheimer's disease"

        Lewybodydementia ->
            "Lewy body dementia"

        FrontotemporaldementiaPicksdisease ->
            "Frontotemporal dementia / Pick's disease"

        CreutzfeldtJakobdisease ->
            "Creutzfeldt-Jakob disease"

        Vasculardementia ->
            "Vascular dementia"

        Parkinsonsdisease ->
            "Parkinson's disease"

        Carpaltunnelsyndrome ->
            "Carpal tunnel syndrome"

        Multiplesclerosis ->
            "Multiple sclerosis"

        Tensionheadache ->
            "Tension headache"

        Clusterheadache ->
            "Cluster headache"

        TemporalarteritisGiantcellarteritis ->
            "Temporal arteritis / Giant cell arteritis"

        GuillainBarresyndrome ->
            "Guillain-Barre syndrome"

        Motorneurondisease ->
            "Motor neuron disease"

        Myastheniagravis ->
            "Myasthenia gravis"

        Myopathy ->
            "Myopathy"

        Osteoarthritis ->
            "Osteoarthritis"

        Gout ->
            "Gout"

        Septicarthritis ->
            "Septic arthritis"

        Rheumatoidarthritis ->
            "Rheumatoid arthritis"

        Systemiclupuserythematosus ->
            "Systemic lupus erythematosus"

        Scleroderma ->
            "Scleroderma"

        Ankylosingspondylitis ->
            "Ankylosing spondylitis"

        Polymyalgiarheumatica ->
            "Polymyalgia rheumatica"

        ANCAassociatedvasculitis ->
            "ANCA-associated vasculitis"

        Skullfracture ->
            "Skull fracture"

        Fractureofhumerus ->
            "Fracture of humerus"

        Fractureofradius ->
            "Fracture of radius"

        Fractureofulna ->
            "Fracture of ulna"

        Fractureoffemur ->
            "Fracture of femur"

        Fractureoftibia ->
            "Fracture of tibia"

        Fractureoffibula ->
            "Fracture of fibula"

        Fractureofscaphoid ->
            "Fracture of scaphoid"

        Softtissueinjury ->
            "Soft tissue injury"

        Irondeficiencyanaemia ->
            "Iron deficiency anaemia"

        VitaminB12deficiency ->
            "Vitamin B12 deficiency"

        Folatedeficiency ->
            "Folate deficiency"

        Haemolyticanaemia ->
            "Haemolytic anaemia"

        Aplasticanaemia ->
            "Aplastic anaemia"

        Sicklecelldisease ->
            "Sickle cell disease"

        Hereditaryspherocytosis ->
            "Hereditary spherocytosis"

        G6PDdeficiency ->
            "G6PD deficiency"

        AcutelymphoblasticleukaemiaALL ->
            "Acute lymphoblastic leukaemia (ALL)"

        AcutemyeloidleukaemiaAML ->
            "Acute myeloid leukaemia (AML)"

        ChroniclymphocyticleukaemiaCLL ->
            "Chronic lymphocytic leukaemia (CLL)"

        ChronicmyeloidleukaemiaCML ->
            "Chronic myeloid leukaemia (CML)"

        Hodgkinlymphoma ->
            "Hodgkin lymphoma"

        Lymphoma ->
            "Lymphoma"

        NonHodgkinlymphoma ->
            "Non-Hodgkin lymphoma"

        Multiplemyeloma ->
            "Multiple myeloma"

        VonWillebranddisease ->
            "Von Willebrand disease"

        HaemophiliaA ->
            "Haemophilia A"

        HaemophiliaB ->
            "Haemophilia B"

        Haemophilia ->
            "Haemophilia"

        Deepveinthrombosis ->
            "Deep vein thrombosis"

        Pulmonaryembolus ->
            "Pulmonary embolus"

        Myelofibrosis ->
            "Myelofibrosis"

        Myelodysplasia ->
            "Myelodysplasia"

        HIVAIDS ->
            "HIV/AIDS"

        Influenza ->
            "Influenza"

        EpsteinBarrvirusEBV ->
            "Epstein-Barr virus (EBV)"

        Denguefever ->
            "Dengue fever"

        Cytomegalovirus ->
            "Cytomegalovirus"

        Typhoidfever ->
            "Typhoid fever"

        Malaria ->
            "Malaria"

        Psoriasis ->
            "Psoriasis"

        Eczema ->
            "Eczema"

        Cellulitis ->
            "Cellulitis"

        Abscess ->
            "Abscess"

        HPV ->
            "HPV"

        Genitalwarts ->
            "Genital warts"

        Melanoma ->
            "Melanoma"

        SquamouscellcarcinomaSCC ->
            "Squamous cell carcinoma (SCC)"

        Basalcellcarcinoma ->
            "Basal cell carcinoma"

        Burns ->
            "Burns"

        Pressureulcer ->
            "Pressure ulcer"

        Conjunctivitis ->
            "Conjunctivitis"

        Blepharitis ->
            "Blepharitis"

        Keratitis ->
            "Keratitis"

        Uveitis ->
            "Uveitis"

        Episcleritis ->
            "Episcleritis"

        Cataract ->
            "Cataract"

        Acuteangleclosureglaucoma ->
            "Acute angle-closure glaucoma"

        Chronicglaucoma ->
            "Chronic glaucoma"

        Retinaldetachment ->
            "Retinal detachment"

        Kawasakisdisease ->
            "Kawasaki's disease"

        TetralogyofFallot ->
            "Tetralogy of Fallot"

        TranspositionoftheGreatArteries ->
            "Transposition of the Great Arteries"

        Patentductusarteriosus ->
            "Patent ductus arteriosus"

        Ventricularseptaldefect ->
            "Ventricular septal defect"

        Coarctationoftheaorta ->
            "Coarctation of the aorta"

        Allergicrhinitis ->
            "Allergic rhinitis"

        Upperairwayobstruction ->
            "Upper airway obstruction"

        Anaphylaxis ->
            "Anaphylaxis"

        Bronchiolitis ->
            "Bronchiolitis"

        Croup ->
            "Croup"

        Osteomyelitis ->
            "Osteomyelitis"

        Febrileconvulsions ->
            "Febrile convulsions"

        Intusussception ->
            "Intusussception"

        Pyloricstenosis ->
            "Pyloric stenosis"

        Appendicitis ->
            "Appendicitis"

        Childabuse ->
            "Child abuse"

        Domesticviolence ->
            "Domestic violence"

        ImmunethrombocytopenicpurpuraITP ->
            "Immune thrombocytopenic purpura (ITP)"

        Idiopathicthrombocytopenia ->
            "Idiopathic thrombocytopenia"

        HenochSchonleinpurpuraHSP ->
            "Henoch-Schonlein purpura (HSP)"

        Thalassaemia ->
            "Thalassaemia"

        Autism ->
            "Autism"

        Downsyndrome ->
            "Down syndrome"

        Seborrheicdermatitis ->
            "Seborrheic dermatitis"

        Measles ->
            "Measles"

        Rubella ->
            "Rubella"

        Scabies ->
            "Scabies"

        Varicellazoster ->
            "Varicella zoster"

        Menieresdisease ->
            "Meniere's disease"

        Presbycusis ->
            "Presbycusis"

        Labyrinthitis ->
            "Labyrinthitis"

        Otitismedia ->
            "Otitis media"

        Otitisexterna ->
            "Otitis externa"

        Acnevulgaris ->
            "Acne vulgaris"

        Acnerosacea ->
            "Acne rosacea"

        Hypoglycaemia ->
            "Hypoglycaemia"

        Suicideattempt ->
            "Suicide attempt"

        Chlamydia ->
            "Chlamydia"

        Gonorrhoea ->
            "Gonorrhoea"

        Bacterialvaginosis ->
            "Bacterial vaginosis"

        Polycysticoveriansyndrome ->
            "Polycystic overian syndrome"

        Pelvicinflammatorydisease ->
            "Pelvic inflammatory disease"

        Endometriosis ->
            "Endometriosis"

        Endometritis ->
            "Endometritis"

        Miscarriage ->
            "Miscarriage"

        Ectopicpregnancy ->
            "Ectopic pregnancy"

        Pregnancy ->
            "Pregnancy"

        Schizophrenia ->
            "Schizophrenia"

        Schizoaffectivedisorder ->
            "Schizoaffective disorder"

        Delusionaldisorder ->
            "Delusional disorder"

        Bipolardisorder ->
            "Bipolar disorder"

        Majordepressivedisorderdepression ->
            "Major depressive disorder / depression"

        Generalisedanxietydisorderanxiety ->
            "Generalised anxiety disorder / anxiety"

        Panicdisorder ->
            "Panic disorder"

        Agoraphobia ->
            "Agoraphobia"

        ObssessivecompulsivedisorderOCD ->
            "Obssessive-compulsive disorder (OCD)"

        Anorexianervosa ->
            "Anorexia nervosa"

        Bulimianervosa ->
            "Bulimia nervosa"

        Schizoidpersonalitydisorder ->
            "Schizoid personality disorder"

        Paranoidpersonalitydisorder ->
            "Paranoid personality disorder"

        Borderlinepersonalitydisorder ->
            "Borderline personality disorder"

        Histrionicpersonalitydisorder ->
            "Histrionic personality disorder"

        Narcissticpersonalitydisorder ->
            "Narcisstic personality disorder"

        Avoidantpersonalitydisorder ->
            "Avoidant personality disorder"

        Schizotypalpersonalitydisorder ->
            "Schizotypal personality disorder"

        Antisocialpersonalitydisorder ->
            "Antisocial personality disorder"

        Dependentpersonalitydisorder ->
            "Dependent personality disorder"

        Obsessivecompulsivepersonalitydisorder ->
            "Obsessive-compulsive personality disorder"

        Delirium ->
            "Delirium"

        Somaticsymptomdisorder ->
            "Somatic symptom disorder"

        Factitiousdisorder ->
            "Factitious disorder"

        Malingering ->
            "Malingering"

        Autismspectrumdisorder ->
            "Autism spectrum disorder"

        AttentiondeficithyperactivitydisorderADHD ->
            "Attention-deficit/hyperactivity disorder (ADHD)"

        Oppositionaldefiantdisorder ->
            "Oppositional defiant disorder"

        Conductdisorder ->
            "Conduct disorder"

        Substanceusedisorder ->
            "Substance use disorder"


list : List Diagnosis
list =
    [ Sicksinussyndrome
    , Bradyarrythmia
    , SupraventricularTachycardia
    , Ventriculartachycardia
    , AcutecoronarysyndromeMyocardialinfarction
    , Stableangina
    , Peripheralvasculardisease
    , Aorticaneurysm
    , Aorticdissection
    , Hypertension
    , Pulmonaryhypertension
    , Varicoseveinschronicvenousinsufficiency
    , Vascularinjury
    , Mitralstenosis
    , Aorticstenosis
    , Aorticregurgitation
    , Mitralregurgitation
    , Tricuspidstenosis
    , Tricuspidregurgitation
    , Pulmonicstenosis
    , Rheumaticfever
    , Infectiveendocarditis
    , Congestivecardiacfailure
    , Cardiomyopathy
    , Myocarditis
    , Acutepericarditis
    , Pericardialeffusion
    , Cardiactamponade
    , Asthma
    , COPD
    , Chronicbronchitis
    , Emphysema
    , Bronchiectasis
    , Cysticfibrosis
    , Pneumonia
    , Tuberculosis
    , Lungcancer
    , Pulmonaryfibrosis
    , Sarcoidosis
    , Ribfracture
    , Obstructivesleepapnoea
    , Pneumothorax
    , Pleuraleffusion
    , Empyema
    , Breastcancer
    , Breastfibroadenoma
    , Mastitis
    , GORD
    , Oesophagealcancer
    , Gastriccancer
    , Achalasia
    , Acutepancreatitis
    , Chronicpancreatitis
    , Pancreatictumour
    , Gastroenteritis
    , Acuteappendicitis
    , Acuteperitonitis
    , Bowelobstruction
    , Ischaemicbowel
    , Crohnsdisease
    , Ulcerativecolitis
    , Inflammatoryboweldisease
    , Colorectalcancer
    , Diverticulardisease
    , Abdominalhernia
    , Coeliacdisease
    , Irritablebowelsyndrome
    , GIST
    , Angiodysplasia
    , Haemorrhoids
    , Perianalfistula
    , Perianalabscess
    , Analfissure
    , Rectalprolapse
    , Analcancer
    , Abdominalinjury
    , HepatitisA
    , HepatitisB
    , HepatitisC
    , Hepaticabscess
    , Cirrhosis
    , Alcoholicliverdisease
    , NAFLD
    , Portalhypertension
    , Wilsonsdisease
    , Alpha1antitrypsindeficiency
    , Hepatocellularcarcinoma
    , Cholelithiasisgallstones
    , Cholecystitis
    , Acutekidneyinjury
    , Urinarytractinfection
    , Urolithiasiskidneystones
    , Nephroticsyndrome
    , Nephriticsyndrome
    , Pyelonephritis
    , Chronicrenalfailure
    , Diabetickidneydisease
    , Polycystickidneydisease
    , Glomerulonephritis
    , Renaltractcarcinoma
    , Bladdercancer
    , Benignprostatichypertrophy
    , Prostatecancer
    , Testiculartumour
    , Hydrocoele
    , Testiculartorsion
    , Epididymoorchitis
    , Type2diabetesmellitus
    , Type1diabetesmellitus
    , Hyperthyroidism
    , Hypothyroidism
    , Nontoxicthyroidnodule
    , Thyroidcancer
    , Cushingssyndrome
    , Addisonsdisease
    , Hyperaldosteronism
    , Phaeochromocytoma
    , Hypopituatarism
    , Pituiaryadenoma
    , Diabetesinsipidus
    , Pituiarycancer
    , Hyperparathyroidism
    , Hypoparathyroidism
    , Obestiy
    , Hyperlipidaemia
    , Osteoporosis
    , Osteomalacia
    , Migraine
    , Stroke
    , Intracranialhaemorrhage
    , Epilepsy
    , Braintumour
    , Meningioma
    , Glioblastoma
    , Meningitis
    , Bacterialmeningitis
    , Viralmeningitis
    , Encephalitis
    , Degenerativediscdisease
    , Spinalcordinjury
    , Myelitis
    , Peripheralneuropathy
    , Subduralhaemorrhage
    , Subarachnoidhaemorrhage
    , Epiduralhaematoma
    , Alzheimersdisease
    , Lewybodydementia
    , FrontotemporaldementiaPicksdisease
    , CreutzfeldtJakobdisease
    , Vasculardementia
    , Parkinsonsdisease
    , Carpaltunnelsyndrome
    , Multiplesclerosis
    , Tensionheadache
    , Clusterheadache
    , TemporalarteritisGiantcellarteritis
    , GuillainBarresyndrome
    , Motorneurondisease
    , Myastheniagravis
    , Myopathy
    , Osteoarthritis
    , Gout
    , Septicarthritis
    , Rheumatoidarthritis
    , Systemiclupuserythematosus
    , Scleroderma
    , Ankylosingspondylitis
    , Polymyalgiarheumatica
    , ANCAassociatedvasculitis
    , Skullfracture
    , Fractureofhumerus
    , Fractureofradius
    , Fractureofulna
    , Fractureoffemur
    , Fractureoftibia
    , Fractureoffibula
    , Fractureofscaphoid
    , Softtissueinjury
    , Irondeficiencyanaemia
    , VitaminB12deficiency
    , Folatedeficiency
    , Haemolyticanaemia
    , Aplasticanaemia
    , Sicklecelldisease
    , Hereditaryspherocytosis
    , G6PDdeficiency
    , AcutelymphoblasticleukaemiaALL
    , AcutemyeloidleukaemiaAML
    , ChroniclymphocyticleukaemiaCLL
    , ChronicmyeloidleukaemiaCML
    , Hodgkinlymphoma
    , Lymphoma
    , NonHodgkinlymphoma
    , Multiplemyeloma
    , VonWillebranddisease
    , HaemophiliaA
    , HaemophiliaB
    , Haemophilia
    , Deepveinthrombosis
    , Pulmonaryembolus
    , Myelofibrosis
    , Myelodysplasia
    , HIVAIDS
    , Influenza
    , EpsteinBarrvirusEBV
    , Denguefever
    , Cytomegalovirus
    , Typhoidfever
    , Malaria
    , Psoriasis
    , Eczema
    , Cellulitis
    , Abscess
    , HPV
    , Genitalwarts
    , Melanoma
    , SquamouscellcarcinomaSCC
    , Basalcellcarcinoma
    , Burns
    , Pressureulcer
    , Conjunctivitis
    , Blepharitis
    , Keratitis
    , Uveitis
    , Episcleritis
    , Cataract
    , Acuteangleclosureglaucoma
    , Chronicglaucoma
    , Retinaldetachment
    , Kawasakisdisease
    , TetralogyofFallot
    , TranspositionoftheGreatArteries
    , Patentductusarteriosus
    , Ventricularseptaldefect
    , Coarctationoftheaorta
    , Allergicrhinitis
    , Upperairwayobstruction
    , Anaphylaxis
    , Bronchiolitis
    , Croup
    , Osteomyelitis
    , Febrileconvulsions
    , Intusussception
    , Pyloricstenosis
    , Appendicitis
    , Childabuse
    , Domesticviolence
    , ImmunethrombocytopenicpurpuraITP
    , Idiopathicthrombocytopenia
    , HenochSchonleinpurpuraHSP
    , Thalassaemia
    , Autism
    , Downsyndrome
    , Seborrheicdermatitis
    , Measles
    , Rubella
    , Scabies
    , Varicellazoster
    , Menieresdisease
    , Presbycusis
    , Labyrinthitis
    , Otitismedia
    , Otitisexterna
    , Acnevulgaris
    , Acnerosacea
    , Hypoglycaemia
    , Suicideattempt
    , Chlamydia
    , Gonorrhoea
    , Bacterialvaginosis
    , Polycysticoveriansyndrome
    , Pelvicinflammatorydisease
    , Endometriosis
    , Endometritis
    , Miscarriage
    , Ectopicpregnancy
    , Pregnancy
    , Schizophrenia
    , Schizoaffectivedisorder
    , Delusionaldisorder
    , Bipolardisorder
    , Majordepressivedisorderdepression
    , Generalisedanxietydisorderanxiety
    , Panicdisorder
    , Agoraphobia
    , ObssessivecompulsivedisorderOCD
    , Anorexianervosa
    , Bulimianervosa
    , Schizoidpersonalitydisorder
    , Paranoidpersonalitydisorder
    , Borderlinepersonalitydisorder
    , Histrionicpersonalitydisorder
    , Narcissticpersonalitydisorder
    , Avoidantpersonalitydisorder
    , Schizotypalpersonalitydisorder
    , Antisocialpersonalitydisorder
    , Dependentpersonalitydisorder
    , Obsessivecompulsivepersonalitydisorder
    , Delirium
    , Somaticsymptomdisorder
    , Factitiousdisorder
    , Malingering
    , Autismspectrumdisorder
    , AttentiondeficithyperactivitydisorderADHD
    , Oppositionaldefiantdisorder
    , Conductdisorder
    , Substanceusedisorder
    ]


optionList : (Diagnosis -> msg) -> List (Option.Data Diagnosis msg)
optionList msg =
    [ { value = Sicksinussyndrome, string = "Sick sinus syndrome", onClick = msg, tags = "" }
    , { value = Bradyarrythmia, string = "Bradyarrythmia", onClick = msg, tags = "" }
    , { value = SupraventricularTachycardia, string = "Supraventricular Tachycardia", onClick = msg, tags = "" }
    , { value = Ventriculartachycardia, string = "Ventricular tachycardia", onClick = msg, tags = "" }
    , { value = AcutecoronarysyndromeMyocardialinfarction, string = "Acute coronary syndrome / Myocardial infarction", onClick = msg, tags = "" }
    , { value = Stableangina, string = "Stable angina", onClick = msg, tags = "" }
    , { value = Peripheralvasculardisease, string = "Peripheral vascular disease", onClick = msg, tags = "" }
    , { value = Aorticaneurysm, string = "Aortic aneurysm", onClick = msg, tags = "" }
    , { value = Aorticdissection, string = "Aortic dissection", onClick = msg, tags = "" }
    , { value = Hypertension, string = "Hypertension", onClick = msg, tags = "" }
    , { value = Pulmonaryhypertension, string = "Pulmonary hypertension", onClick = msg, tags = "" }
    , { value = Varicoseveinschronicvenousinsufficiency, string = "Varicose veins / chronic venous insufficiency", onClick = msg, tags = "" }
    , { value = Vascularinjury, string = "Vascular injury", onClick = msg, tags = "" }
    , { value = Mitralstenosis, string = "Mitral stenosis", onClick = msg, tags = "" }
    , { value = Aorticstenosis, string = "Aortic stenosis", onClick = msg, tags = "" }
    , { value = Aorticregurgitation, string = "Aortic regurgitation", onClick = msg, tags = "" }
    , { value = Mitralregurgitation, string = "Mitral regurgitation", onClick = msg, tags = "" }
    , { value = Tricuspidstenosis, string = "Tricuspid stenosis", onClick = msg, tags = "" }
    , { value = Tricuspidregurgitation, string = "Tricuspid regurgitation", onClick = msg, tags = "" }
    , { value = Pulmonicstenosis, string = "Pulmonic stenosis", onClick = msg, tags = "" }
    , { value = Rheumaticfever, string = "Rheumatic fever", onClick = msg, tags = "" }
    , { value = Infectiveendocarditis, string = "Infective endocarditis", onClick = msg, tags = "" }
    , { value = Congestivecardiacfailure, string = "Congestive cardiac failure", onClick = msg, tags = "" }
    , { value = Cardiomyopathy, string = "Cardiomyopathy", onClick = msg, tags = "" }
    , { value = Myocarditis, string = "Myocarditis", onClick = msg, tags = "" }
    , { value = Acutepericarditis, string = "Acute pericarditis", onClick = msg, tags = "" }
    , { value = Pericardialeffusion, string = "Pericardial effusion", onClick = msg, tags = "" }
    , { value = Cardiactamponade, string = "Cardiac tamponade", onClick = msg, tags = "" }
    , { value = Asthma, string = "Asthma", onClick = msg, tags = "" }
    , { value = COPD, string = "COPD", onClick = msg, tags = "" }
    , { value = Chronicbronchitis, string = "Chronic bronchitis", onClick = msg, tags = "" }
    , { value = Emphysema, string = "Emphysema", onClick = msg, tags = "" }
    , { value = Bronchiectasis, string = "Bronchiectasis", onClick = msg, tags = "" }
    , { value = Cysticfibrosis, string = "Cystic fibrosis", onClick = msg, tags = "" }
    , { value = Pneumonia, string = "Pneumonia", onClick = msg, tags = "" }
    , { value = Tuberculosis, string = "Tuberculosis", onClick = msg, tags = "" }
    , { value = Lungcancer, string = "Lung cancer", onClick = msg, tags = "" }
    , { value = Pulmonaryfibrosis, string = "Pulmonary fibrosis", onClick = msg, tags = "" }
    , { value = Sarcoidosis, string = "Sarcoidosis", onClick = msg, tags = "" }
    , { value = Ribfracture, string = "Rib fracture", onClick = msg, tags = "" }
    , { value = Obstructivesleepapnoea, string = "Obstructive sleep apnoea", onClick = msg, tags = "" }
    , { value = Pneumothorax, string = "Pneumothorax", onClick = msg, tags = "" }
    , { value = Pleuraleffusion, string = "Pleural effusion", onClick = msg, tags = "" }
    , { value = Empyema, string = "Empyema", onClick = msg, tags = "" }
    , { value = Breastcancer, string = "Breast cancer", onClick = msg, tags = "" }
    , { value = Breastfibroadenoma, string = "Breast fibroadenoma", onClick = msg, tags = "" }
    , { value = Mastitis, string = "Mastitis", onClick = msg, tags = "" }
    , { value = GORD, string = "GORD", onClick = msg, tags = "" }
    , { value = Oesophagealcancer, string = "Oesophageal cancer", onClick = msg, tags = "" }
    , { value = Gastriccancer, string = "Gastric cancer", onClick = msg, tags = "" }
    , { value = Achalasia, string = "Achalasia", onClick = msg, tags = "" }
    , { value = Acutepancreatitis, string = "Acute pancreatitis", onClick = msg, tags = "" }
    , { value = Chronicpancreatitis, string = "Chronic pancreatitis", onClick = msg, tags = "" }
    , { value = Pancreatictumour, string = "Pancreatic tumour", onClick = msg, tags = "" }
    , { value = Gastroenteritis, string = "Gastroenteritis", onClick = msg, tags = "" }
    , { value = Acuteappendicitis, string = "Acute appendicitis", onClick = msg, tags = "" }
    , { value = Acuteperitonitis, string = "Acute peritonitis", onClick = msg, tags = "" }
    , { value = Bowelobstruction, string = "Bowel obstruction", onClick = msg, tags = "" }
    , { value = Ischaemicbowel, string = "Ischaemic bowel", onClick = msg, tags = "" }
    , { value = Crohnsdisease, string = "Crohn's disease", onClick = msg, tags = "" }
    , { value = Ulcerativecolitis, string = "Ulcerative colitis", onClick = msg, tags = "" }
    , { value = Inflammatoryboweldisease, string = "Inflammatory bowel disease", onClick = msg, tags = "" }
    , { value = Colorectalcancer, string = "Colorectal cancer", onClick = msg, tags = "" }
    , { value = Diverticulardisease, string = "Diverticular disease", onClick = msg, tags = "" }
    , { value = Abdominalhernia, string = "Abdominal hernia", onClick = msg, tags = "" }
    , { value = Coeliacdisease, string = "Coeliac disease", onClick = msg, tags = "" }
    , { value = Irritablebowelsyndrome, string = "Irritable bowel syndrome", onClick = msg, tags = "" }
    , { value = GIST, string = "GIST", onClick = msg, tags = "" }
    , { value = Angiodysplasia, string = "Angiodysplasia", onClick = msg, tags = "" }
    , { value = Haemorrhoids, string = "Haemorrhoids", onClick = msg, tags = "" }
    , { value = Perianalfistula, string = "Perianal fistula", onClick = msg, tags = "" }
    , { value = Perianalabscess, string = "Perianal abscess", onClick = msg, tags = "" }
    , { value = Analfissure, string = "Anal fissure", onClick = msg, tags = "" }
    , { value = Rectalprolapse, string = "Rectal prolapse", onClick = msg, tags = "" }
    , { value = Analcancer, string = "Anal cancer", onClick = msg, tags = "" }
    , { value = Abdominalinjury, string = "Abdominal injury", onClick = msg, tags = "" }
    , { value = HepatitisA, string = "Hepatitis A", onClick = msg, tags = "" }
    , { value = HepatitisB, string = "Hepatitis B", onClick = msg, tags = "" }
    , { value = HepatitisC, string = "Hepatitis C", onClick = msg, tags = "" }
    , { value = Hepaticabscess, string = "Hepatic abscess", onClick = msg, tags = "" }
    , { value = Cirrhosis, string = "Cirrhosis", onClick = msg, tags = "" }
    , { value = Alcoholicliverdisease, string = "Alcoholic liver disease", onClick = msg, tags = "" }
    , { value = NAFLD, string = "NAFLD", onClick = msg, tags = "" }
    , { value = Portalhypertension, string = "Portal hypertension", onClick = msg, tags = "" }
    , { value = Wilsonsdisease, string = "Wilson's disease", onClick = msg, tags = "" }
    , { value = Alpha1antitrypsindeficiency, string = "Alpha-1 antitrypsin deficiency", onClick = msg, tags = "" }
    , { value = Hepatocellularcarcinoma, string = "Hepatocellular carcinoma", onClick = msg, tags = "" }
    , { value = Cholelithiasisgallstones, string = "Cholelithiasis / gallstones", onClick = msg, tags = "" }
    , { value = Cholecystitis, string = "Cholecystitis", onClick = msg, tags = "" }
    , { value = Acutekidneyinjury, string = "Acute kidney injury", onClick = msg, tags = "" }
    , { value = Urinarytractinfection, string = "Urinary tract infection", onClick = msg, tags = "" }
    , { value = Urolithiasiskidneystones, string = "Urolithiasis / kidney stones", onClick = msg, tags = "" }
    , { value = Nephroticsyndrome, string = "Nephrotic syndrome", onClick = msg, tags = "" }
    , { value = Nephriticsyndrome, string = "Nephritic syndrome", onClick = msg, tags = "" }
    , { value = Pyelonephritis, string = "Pyelonephritis", onClick = msg, tags = "" }
    , { value = Chronicrenalfailure, string = "Chronic renal failure", onClick = msg, tags = "" }
    , { value = Diabetickidneydisease, string = "Diabetic kidney disease", onClick = msg, tags = "" }
    , { value = Polycystickidneydisease, string = "Polycystic kidney disease", onClick = msg, tags = "" }
    , { value = Glomerulonephritis, string = "Glomerulonephritis", onClick = msg, tags = "" }
    , { value = Renaltractcarcinoma, string = "Renal tract carcinoma", onClick = msg, tags = "" }
    , { value = Bladdercancer, string = "Bladder cancer", onClick = msg, tags = "" }
    , { value = Benignprostatichypertrophy, string = "Benign prostatic hypertrophy", onClick = msg, tags = "" }
    , { value = Prostatecancer, string = "Prostate cancer", onClick = msg, tags = "" }
    , { value = Testiculartumour, string = "Testicular tumour", onClick = msg, tags = "" }
    , { value = Hydrocoele, string = "Hydrocoele", onClick = msg, tags = "" }
    , { value = Testiculartorsion, string = "Testicular torsion", onClick = msg, tags = "" }
    , { value = Epididymoorchitis, string = "Epididymoorchitis", onClick = msg, tags = "" }
    , { value = Type2diabetesmellitus, string = "Type 2 diabetes mellitus", onClick = msg, tags = "" }
    , { value = Type1diabetesmellitus, string = "Type 1 diabetes mellitus", onClick = msg, tags = "" }
    , { value = Hyperthyroidism, string = "Hyperthyroidism", onClick = msg, tags = "" }
    , { value = Hypothyroidism, string = "Hypothyroidism", onClick = msg, tags = "" }
    , { value = Nontoxicthyroidnodule, string = "Non-toxic thyroid nodule", onClick = msg, tags = "" }
    , { value = Thyroidcancer, string = "Thyroid cancer", onClick = msg, tags = "" }
    , { value = Cushingssyndrome, string = "Cushing's syndrome", onClick = msg, tags = "" }
    , { value = Addisonsdisease, string = "Addison's disease", onClick = msg, tags = "" }
    , { value = Hyperaldosteronism, string = "Hyperaldosteronism", onClick = msg, tags = "" }
    , { value = Phaeochromocytoma, string = "Phaeochromocytoma", onClick = msg, tags = "" }
    , { value = Hypopituatarism, string = "Hypopituatarism", onClick = msg, tags = "" }
    , { value = Pituiaryadenoma, string = "Pituiary adenoma", onClick = msg, tags = "" }
    , { value = Diabetesinsipidus, string = "Diabetes insipidus", onClick = msg, tags = "" }
    , { value = Pituiarycancer, string = "Pituiary cancer", onClick = msg, tags = "" }
    , { value = Hyperparathyroidism, string = "Hyperparathyroidism", onClick = msg, tags = "" }
    , { value = Hypoparathyroidism, string = "Hypoparathyroidism", onClick = msg, tags = "" }
    , { value = Obestiy, string = "Obestiy", onClick = msg, tags = "" }
    , { value = Hyperlipidaemia, string = "Hyperlipidaemia", onClick = msg, tags = "" }
    , { value = Osteoporosis, string = "Osteoporosis", onClick = msg, tags = "" }
    , { value = Osteomalacia, string = "Osteomalacia", onClick = msg, tags = "" }
    , { value = Migraine, string = "Migraine", onClick = msg, tags = "" }
    , { value = Stroke, string = "Stroke", onClick = msg, tags = "" }
    , { value = Intracranialhaemorrhage, string = "intracranial haemorrhage", onClick = msg, tags = "" }
    , { value = Epilepsy, string = "Epilepsy", onClick = msg, tags = "" }
    , { value = Braintumour, string = "Brain tumour", onClick = msg, tags = "" }
    , { value = Meningioma, string = "Meningioma", onClick = msg, tags = "" }
    , { value = Glioblastoma, string = "Glioblastoma", onClick = msg, tags = "" }
    , { value = Meningitis, string = "Meningitis", onClick = msg, tags = "" }
    , { value = Bacterialmeningitis, string = "Bacterial meningitis", onClick = msg, tags = "" }
    , { value = Viralmeningitis, string = "Viral meningitis", onClick = msg, tags = "" }
    , { value = Encephalitis, string = "Encephalitis", onClick = msg, tags = "" }
    , { value = Degenerativediscdisease, string = "Degenerative disc disease", onClick = msg, tags = "" }
    , { value = Spinalcordinjury, string = "Spinal cord injury", onClick = msg, tags = "" }
    , { value = Myelitis, string = "Myelitis", onClick = msg, tags = "" }
    , { value = Peripheralneuropathy, string = "Peripheral neuropathy", onClick = msg, tags = "" }
    , { value = Subduralhaemorrhage, string = "Subdural haemorrhage", onClick = msg, tags = "" }
    , { value = Subarachnoidhaemorrhage, string = "Subarachnoid haemorrhage", onClick = msg, tags = "" }
    , { value = Epiduralhaematoma, string = "Epidural haematoma", onClick = msg, tags = "" }
    , { value = Alzheimersdisease, string = "Alzheimer's disease", onClick = msg, tags = "" }
    , { value = Lewybodydementia, string = "Lewy body dementia", onClick = msg, tags = "" }
    , { value = FrontotemporaldementiaPicksdisease, string = "Frontotemporal dementia / Pick's disease", onClick = msg, tags = "" }
    , { value = CreutzfeldtJakobdisease, string = "Creutzfeldt-Jakob disease", onClick = msg, tags = "" }
    , { value = Vasculardementia, string = "Vascular dementia", onClick = msg, tags = "" }
    , { value = Parkinsonsdisease, string = "Parkinson's disease", onClick = msg, tags = "" }
    , { value = Carpaltunnelsyndrome, string = "Carpal tunnel syndrome", onClick = msg, tags = "" }
    , { value = Multiplesclerosis, string = "Multiple sclerosis", onClick = msg, tags = "" }
    , { value = Tensionheadache, string = "Tension headache", onClick = msg, tags = "" }
    , { value = Clusterheadache, string = "Cluster headache", onClick = msg, tags = "" }
    , { value = TemporalarteritisGiantcellarteritis, string = "Temporal arteritis / Giant cell arteritis", onClick = msg, tags = "" }
    , { value = GuillainBarresyndrome, string = "Guillain-Barre syndrome", onClick = msg, tags = "" }
    , { value = Motorneurondisease, string = "Motor neuron disease", onClick = msg, tags = "" }
    , { value = Myastheniagravis, string = "Myasthenia gravis", onClick = msg, tags = "" }
    , { value = Myopathy, string = "Myopathy", onClick = msg, tags = "" }
    , { value = Osteoarthritis, string = "Osteoarthritis", onClick = msg, tags = "" }
    , { value = Gout, string = "Gout", onClick = msg, tags = "" }
    , { value = Septicarthritis, string = "Septic arthritis", onClick = msg, tags = "" }
    , { value = Rheumatoidarthritis, string = "Rheumatoid arthritis", onClick = msg, tags = "" }
    , { value = Systemiclupuserythematosus, string = "Systemic lupus erythematosus", onClick = msg, tags = "" }
    , { value = Scleroderma, string = "Scleroderma", onClick = msg, tags = "" }
    , { value = Ankylosingspondylitis, string = "Ankylosing spondylitis", onClick = msg, tags = "" }
    , { value = Polymyalgiarheumatica, string = "Polymyalgia rheumatica", onClick = msg, tags = "" }
    , { value = ANCAassociatedvasculitis, string = "ANCA-associated vasculitis", onClick = msg, tags = "" }
    , { value = Skullfracture, string = "Skull fracture", onClick = msg, tags = "" }
    , { value = Fractureofhumerus, string = "Fracture of humerus", onClick = msg, tags = "" }
    , { value = Fractureofradius, string = "Fracture of radius", onClick = msg, tags = "" }
    , { value = Fractureofulna, string = "Fracture of ulna", onClick = msg, tags = "" }
    , { value = Fractureoffemur, string = "Fracture of femur", onClick = msg, tags = "" }
    , { value = Fractureoftibia, string = "Fracture of tibia", onClick = msg, tags = "" }
    , { value = Fractureoffibula, string = "Fracture of fibula", onClick = msg, tags = "" }
    , { value = Fractureofscaphoid, string = "Fracture of scaphoid", onClick = msg, tags = "" }
    , { value = Softtissueinjury, string = "Soft tissue injury", onClick = msg, tags = "" }
    , { value = Irondeficiencyanaemia, string = "Iron deficiency anaemia", onClick = msg, tags = "" }
    , { value = VitaminB12deficiency, string = "Vitamin B12 deficiency", onClick = msg, tags = "" }
    , { value = Folatedeficiency, string = "Folate deficiency", onClick = msg, tags = "" }
    , { value = Haemolyticanaemia, string = "Haemolytic anaemia", onClick = msg, tags = "" }
    , { value = Aplasticanaemia, string = "Aplastic anaemia", onClick = msg, tags = "" }
    , { value = Sicklecelldisease, string = "Sickle cell disease", onClick = msg, tags = "" }
    , { value = Hereditaryspherocytosis, string = "Hereditary spherocytosis", onClick = msg, tags = "" }
    , { value = G6PDdeficiency, string = "G6PD deficiency", onClick = msg, tags = "" }
    , { value = AcutelymphoblasticleukaemiaALL, string = "Acute lymphoblastic leukaemia (ALL)", onClick = msg, tags = "" }
    , { value = AcutemyeloidleukaemiaAML, string = "Acute myeloid leukaemia (AML)", onClick = msg, tags = "" }
    , { value = ChroniclymphocyticleukaemiaCLL, string = "Chronic lymphocytic leukaemia (CLL)", onClick = msg, tags = "" }
    , { value = ChronicmyeloidleukaemiaCML, string = "Chronic myeloid leukaemia (CML)", onClick = msg, tags = "" }
    , { value = Hodgkinlymphoma, string = "Hodgkin lymphoma", onClick = msg, tags = "" }
    , { value = Lymphoma, string = "Lymphoma", onClick = msg, tags = "" }
    , { value = NonHodgkinlymphoma, string = "Non-Hodgkin lymphoma", onClick = msg, tags = "" }
    , { value = Multiplemyeloma, string = "Multiple myeloma", onClick = msg, tags = "" }
    , { value = VonWillebranddisease, string = "Von Willebrand disease", onClick = msg, tags = "" }
    , { value = HaemophiliaA, string = "Haemophilia A", onClick = msg, tags = "" }
    , { value = HaemophiliaB, string = "Haemophilia B", onClick = msg, tags = "" }
    , { value = Haemophilia, string = "Haemophilia", onClick = msg, tags = "" }
    , { value = Deepveinthrombosis, string = "Deep vein thrombosis", onClick = msg, tags = "" }
    , { value = Pulmonaryembolus, string = "Pulmonary embolus", onClick = msg, tags = "" }
    , { value = Myelofibrosis, string = "Myelofibrosis", onClick = msg, tags = "" }
    , { value = Myelodysplasia, string = "Myelodysplasia", onClick = msg, tags = "" }
    , { value = HIVAIDS, string = "HIV/AIDS", onClick = msg, tags = "" }
    , { value = Influenza, string = "Influenza", onClick = msg, tags = "" }
    , { value = EpsteinBarrvirusEBV, string = "Epstein-Barr virus (EBV)", onClick = msg, tags = "" }
    , { value = Denguefever, string = "Dengue fever", onClick = msg, tags = "" }
    , { value = Cytomegalovirus, string = "Cytomegalovirus", onClick = msg, tags = "" }
    , { value = Typhoidfever, string = "Typhoid fever", onClick = msg, tags = "" }
    , { value = Malaria, string = "Malaria", onClick = msg, tags = "" }
    , { value = Psoriasis, string = "Psoriasis", onClick = msg, tags = "" }
    , { value = Eczema, string = "Eczema", onClick = msg, tags = "" }
    , { value = Cellulitis, string = "Cellulitis", onClick = msg, tags = "" }
    , { value = Abscess, string = "Abscess", onClick = msg, tags = "" }
    , { value = HPV, string = "HPV", onClick = msg, tags = "" }
    , { value = Genitalwarts, string = "Genital warts", onClick = msg, tags = "" }
    , { value = Melanoma, string = "Melanoma", onClick = msg, tags = "" }
    , { value = SquamouscellcarcinomaSCC, string = "Squamous cell carcinoma (SCC)", onClick = msg, tags = "" }
    , { value = Basalcellcarcinoma, string = "Basal cell carcinoma", onClick = msg, tags = "" }
    , { value = Burns, string = "Burns", onClick = msg, tags = "" }
    , { value = Pressureulcer, string = "Pressure ulcer", onClick = msg, tags = "" }
    , { value = Conjunctivitis, string = "Conjunctivitis", onClick = msg, tags = "" }
    , { value = Blepharitis, string = "Blepharitis", onClick = msg, tags = "" }
    , { value = Keratitis, string = "Keratitis", onClick = msg, tags = "" }
    , { value = Uveitis, string = "Uveitis", onClick = msg, tags = "" }
    , { value = Episcleritis, string = "Episcleritis", onClick = msg, tags = "" }
    , { value = Cataract, string = "Cataract", onClick = msg, tags = "" }
    , { value = Acuteangleclosureglaucoma, string = "Acute angle-closure glaucoma", onClick = msg, tags = "" }
    , { value = Chronicglaucoma, string = "Chronic glaucoma", onClick = msg, tags = "" }
    , { value = Retinaldetachment, string = "Retinal detachment", onClick = msg, tags = "" }
    , { value = Kawasakisdisease, string = "Kawasaki's disease", onClick = msg, tags = "" }
    , { value = TetralogyofFallot, string = "Tetralogy of Fallot", onClick = msg, tags = "" }
    , { value = TranspositionoftheGreatArteries, string = "Transposition of the Great Arteries", onClick = msg, tags = "" }
    , { value = Patentductusarteriosus, string = "Patent ductus arteriosus", onClick = msg, tags = "" }
    , { value = Ventricularseptaldefect, string = "Ventricular septal defect", onClick = msg, tags = "" }
    , { value = Coarctationoftheaorta, string = "Coarctation of the aorta", onClick = msg, tags = "" }
    , { value = Allergicrhinitis, string = "Allergic rhinitis", onClick = msg, tags = "" }
    , { value = Upperairwayobstruction, string = "Upper airway obstruction", onClick = msg, tags = "" }
    , { value = Anaphylaxis, string = "Anaphylaxis", onClick = msg, tags = "" }
    , { value = Bronchiolitis, string = "Bronchiolitis", onClick = msg, tags = "" }
    , { value = Croup, string = "Croup", onClick = msg, tags = "" }
    , { value = Osteomyelitis, string = "Osteomyelitis", onClick = msg, tags = "" }
    , { value = Febrileconvulsions, string = "Febrile convulsions", onClick = msg, tags = "" }
    , { value = Intusussception, string = "Intusussception", onClick = msg, tags = "" }
    , { value = Pyloricstenosis, string = "Pyloric stenosis", onClick = msg, tags = "" }
    , { value = Appendicitis, string = "Appendicitis", onClick = msg, tags = "" }
    , { value = Childabuse, string = "Child abuse", onClick = msg, tags = "" }
    , { value = Domesticviolence, string = "Domestic violence", onClick = msg, tags = "" }
    , { value = ImmunethrombocytopenicpurpuraITP, string = "Immune thrombocytopenic purpura (ITP)", onClick = msg, tags = "" }
    , { value = Idiopathicthrombocytopenia, string = "Idiopathic thrombocytopenia", onClick = msg, tags = "" }
    , { value = HenochSchonleinpurpuraHSP, string = "Henoch-Schonlein purpura (HSP)", onClick = msg, tags = "" }
    , { value = Thalassaemia, string = "Thalassaemia", onClick = msg, tags = "" }
    , { value = Autism, string = "Autism", onClick = msg, tags = "" }
    , { value = Downsyndrome, string = "Down syndrome", onClick = msg, tags = "" }
    , { value = Seborrheicdermatitis, string = "Seborrheic dermatitis", onClick = msg, tags = "" }
    , { value = Measles, string = "Measles", onClick = msg, tags = "" }
    , { value = Rubella, string = "Rubella", onClick = msg, tags = "" }
    , { value = Scabies, string = "Scabies", onClick = msg, tags = "" }
    , { value = Varicellazoster, string = "Varicella zoster", onClick = msg, tags = "" }
    , { value = Menieresdisease, string = "Meniere's disease", onClick = msg, tags = "" }
    , { value = Presbycusis, string = "Presbycusis", onClick = msg, tags = "" }
    , { value = Labyrinthitis, string = "Labyrinthitis", onClick = msg, tags = "" }
    , { value = Otitismedia, string = "Otitis media", onClick = msg, tags = "" }
    , { value = Otitisexterna, string = "Otitis externa", onClick = msg, tags = "" }
    , { value = Acnevulgaris, string = "Acne vulgaris", onClick = msg, tags = "" }
    , { value = Acnerosacea, string = "Acne rosacea", onClick = msg, tags = "" }
    , { value = Hypoglycaemia, string = "Hypoglycaemia", onClick = msg, tags = "" }
    , { value = Suicideattempt, string = "Suicide attempt", onClick = msg, tags = "" }
    , { value = Chlamydia, string = "Chlamydia", onClick = msg, tags = "" }
    , { value = Gonorrhoea, string = "Gonorrhoea", onClick = msg, tags = "" }
    , { value = Bacterialvaginosis, string = "Bacterial vaginosis", onClick = msg, tags = "" }
    , { value = Polycysticoveriansyndrome, string = "Polycystic overian syndrome", onClick = msg, tags = "" }
    , { value = Pelvicinflammatorydisease, string = "Pelvic inflammatory disease", onClick = msg, tags = "" }
    , { value = Endometriosis, string = "Endometriosis", onClick = msg, tags = "" }
    , { value = Endometritis, string = "Endometritis", onClick = msg, tags = "" }
    , { value = Miscarriage, string = "Miscarriage", onClick = msg, tags = "" }
    , { value = Ectopicpregnancy, string = "Ectopic pregnancy", onClick = msg, tags = "" }
    , { value = Pregnancy, string = "Pregnancy", onClick = msg, tags = "" }
    , { value = Schizophrenia, string = "Schizophrenia", onClick = msg, tags = "" }
    , { value = Schizoaffectivedisorder, string = "Schizoaffective disorder", onClick = msg, tags = "" }
    , { value = Delusionaldisorder, string = "Delusional disorder", onClick = msg, tags = "" }
    , { value = Bipolardisorder, string = "Bipolar disorder", onClick = msg, tags = "" }
    , { value = Majordepressivedisorderdepression, string = "Major depressive disorder / depression", onClick = msg, tags = "" }
    , { value = Generalisedanxietydisorderanxiety, string = "Generalised anxiety disorder / anxiety", onClick = msg, tags = "" }
    , { value = Panicdisorder, string = "Panic disorder", onClick = msg, tags = "" }
    , { value = Agoraphobia, string = "Agoraphobia", onClick = msg, tags = "" }
    , { value = ObssessivecompulsivedisorderOCD, string = "Obssessive-compulsive disorder (OCD)", onClick = msg, tags = "" }
    , { value = Anorexianervosa, string = "Anorexia nervosa", onClick = msg, tags = "" }
    , { value = Bulimianervosa, string = "Bulimia nervosa", onClick = msg, tags = "" }
    , { value = Schizoidpersonalitydisorder, string = "Schizoid personality disorder", onClick = msg, tags = "" }
    , { value = Paranoidpersonalitydisorder, string = "Paranoid personality disorder", onClick = msg, tags = "" }
    , { value = Borderlinepersonalitydisorder, string = "Borderline personality disorder", onClick = msg, tags = "" }
    , { value = Histrionicpersonalitydisorder, string = "Histrionic personality disorder", onClick = msg, tags = "" }
    , { value = Narcissticpersonalitydisorder, string = "Narcisstic personality disorder", onClick = msg, tags = "" }
    , { value = Avoidantpersonalitydisorder, string = "Avoidant personality disorder", onClick = msg, tags = "" }
    , { value = Schizotypalpersonalitydisorder, string = "Schizotypal personality disorder", onClick = msg, tags = "" }
    , { value = Antisocialpersonalitydisorder, string = "Antisocial personality disorder", onClick = msg, tags = "" }
    , { value = Dependentpersonalitydisorder, string = "Dependent personality disorder", onClick = msg, tags = "" }
    , { value = Obsessivecompulsivepersonalitydisorder, string = "Obsessive-compulsive personality disorder", onClick = msg, tags = "" }
    , { value = Delirium, string = "Delirium", onClick = msg, tags = "" }
    , { value = Somaticsymptomdisorder, string = "Somatic symptom disorder", onClick = msg, tags = "" }
    , { value = Factitiousdisorder, string = "Factitious disorder", onClick = msg, tags = "" }
    , { value = Malingering, string = "Malingering", onClick = msg, tags = "" }
    , { value = Autismspectrumdisorder, string = "Autism spectrum disorder", onClick = msg, tags = "" }
    , { value = AttentiondeficithyperactivitydisorderADHD, string = "Attention-deficit/hyperactivity disorder (ADHD)", onClick = msg, tags = "" }
    , { value = Oppositionaldefiantdisorder, string = "Oppositional defiant disorder", onClick = msg, tags = "" }
    , { value = Conductdisorder, string = "Conduct disorder", onClick = msg, tags = "" }
    , { value = Substanceusedisorder, string = "Substance use disorder", onClick = msg, tags = "" }
    ]
