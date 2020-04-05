
module Cases.MargaretSmith55FLawyer exposing (..)

import Array exposing (..)
import Cases.Case as Case exposing (..)
import Diagnosis exposing (..)
import Investigations.Bloods exposing (..)
import Investigations.Imaging exposing (..)
import Investigations.Investigation as Investigation exposing (..)
import Investigations.Other exposing (..)
import Medication exposing (..)
import Prescription exposing (..)
import Questions.Alcohol as Alcohol exposing (..)
import Questions.Details as Details exposing (..)
import Questions.Drugs as Drugs exposing (..)
import Questions.Examine as Examine exposing (..)
import Questions.Fhx as Fhx exposing (..)
import Questions.LocFeature as LocFeature exposing (..)
import Questions.Open as Open exposing (..)
import Questions.PainFeature as PainFeature exposing (..)
import Questions.Phx as Phx exposing (..)
import Questions.Shx as Shx exposing (..)
import Questions.Sign as Sign exposing (..)
import Questions.Smoke as Smoke exposing (..)
import Questions.Symptom as Symptom exposing (..)
import Questions.SymptomFeature as SymptomFeature exposing (..)
import Questions.Feelings as Feelings exposing (..)
import Questions.Question as Question exposing (..)
import Set exposing (Set)
import Dict exposing (Dict)

script : Int -> String
script questionId =
    case (Dict.get questionId scriptDict) of
        Just response -> 
            response
        Nothing -> 
            case (Question.fromInt questionId) of
                QuestionOpen _ ->
                    "What exactly would you like to know?"

                QuestionSymptom _ ->
                    "No."

                QuestionExamine _ ->
                    "On gross examination, you didn't notice anything abnormal. But you might need to be more specific."

                QuestionSign _ ->
                    "No abnormality detected."

                _ ->
                    "Sorry, I'm not sure about that."

scriptDict : Dict Int String
scriptDict = Dict.fromList 
    [ (Question.toInt (QuestionAlcohol Alcohol.Quantity), """Oh I'd say I'm just an occasional drinker. A glass of wine occasionally at night, that sort of thing. """)
    , (Question.toInt (QuestionAlcohol Alcohol.YesNo), """A little bit, yes.""")
    , (Question.toInt (QuestionDetails Details.OccupationBrief), """I work as a solicitor. It's a fine job.""")
    , (Question.toInt (QuestionDetails Details.Age), """I'm 55 years old. Goodness, I'm getting old!""")
    , (Question.toInt (QuestionDetails Details.Dob), """I was born on the 5th August 1964. """)
    , (Question.toInt (QuestionDetails Details.Name), """My name's Margaret Smith. Pleasure to meet you.""")
    , (Question.toInt (QuestionDetails Details.OccupationDescription), """It's mostly office work, though sometimes it does get very stressful. My clients often have very high expectations you know!""")
    , (Question.toInt (QuestionDrugs Drugs.Recreational), """Oh no, I would never take recreational drugs. """)
    , (Question.toInt (QuestionDrugs Drugs.Regular), """Let's see, I've got Coversyl for the blood pressure, then I've got an anxiety medication, I forgot what that's called. I have a puffer for my asthma too. """)
    , (Question.toInt (QuestionDrugs Drugs.Otc), """Oh I take a multivitamin every day. Just the ones you get from the supermarket.""")
    , (Question.toInt (QuestionDrugs Drugs.Allergies), """Not that I know of.""")
    , (Question.toInt (QuestionExamine Examine.General), """You see a middle-aged lady with normal body habitus in bed, looking tired but conscious.""")
    , (Question.toInt (QuestionExamine Examine.Weight), """Margaret currently weighs 64kg.""")
    , (Question.toInt (QuestionExamine Examine.Oxygen), """98% on room air.""")
    , (Question.toInt (QuestionExamine Examine.GCS), """Eyes opening spontaneously, speaking coherently, spontaneous motor movement. """)
    , (Question.toInt (QuestionExamine Examine.EyeMovements), """The eye movements appear grossly normal, though Margaret mentions she sees double when she attempts to look laterally.""")
    , (Question.toInt (QuestionExamine Examine.Vitals), """HR 90bpm, BP 170/130, RR 18, T 37.2""")
    , (Question.toInt (QuestionExamine Examine.Fundus), """The optic disc looks a bit swollen.""")
    , (Question.toInt (QuestionExamine Examine.Surroundings), """There's a book on the table.""")
    , (Question.toInt (QuestionExamine Examine.Pupils), """Pupil size approximately 4mm. Pupils equal and reactive to light. """)
    , (Question.toInt (QuestionExamine Examine.MentalState), """You notice Margaret appears somewhat distractible. She scores 22/30 on an MMSE, losing points for serial sevens (1/5), recall (1/3) and three-stage command (1/3).""")
    , (Question.toInt (QuestionFhx Fhx.Siblings), """I have an older brother and a younger sister.""")
    , (Question.toInt (QuestionFhx Fhx.Children), """I've got a daughter, she's 20, and a son, he's 12. """)
    , (Question.toInt (QuestionFhx Fhx.ChildrenHealth), """My children are fairly well. My youngest had asthma for a while, but that went away.""")
    , (Question.toInt (QuestionFhx Fhx.ParentHealth), """My mom had some problem with her kidneys. Something like polycystic kidney disease? She passed away from a stroke in her 50s. My dad's still with us though, he's going strong.""")
    , (Question.toInt (QuestionFhx Fhx.SiblingsHealth), """I think they're okay. I don't talk to them much.""")
    , (Question.toInt (QuestionLocFeature LocFeature.When), """It was just a bit earlier today. I don't know how long I was out for, but it couldn't have been too long.""")
    , (Question.toInt (QuestionOpen Open.Greeting), """It's a pleasure to meet you too. I just wish it were under different circumstances...""")
    , (Question.toInt (QuestionOpen Open.Symptoms), """My head's a bit fuzzy at the moment, could you name some sympoms? """)
    , (Question.toInt (QuestionOpen Open.Fhx), """Well what would you like to know?""")
    , (Question.toInt (QuestionOpen Open.Phx), """I think I've got high blood pressure or something like that.""")
    , (Question.toInt (QuestionOpen Open.Opening), """Well, I've got this absolutely terrible headache. Really terrible. I talked to my GP and he told me to come straight here. """)
    , (Question.toInt (QuestionPainFeature PainFeature.Quality), """It sort of feels like a thumping.""")
    , (Question.toInt (QuestionPainFeature PainFeature.Activity), """I was just at home reading a book.. it all happened so suddenly. I immediately rang my GP and managed to get an urgent appointment, then he told me to come here straight away. """)
    , (Question.toInt (QuestionPainFeature PainFeature.Quantity), """It's 10/10. I mean, I've had headaches before but this is something else - definitely the worst headache of my life.""")
    , (Question.toInt (QuestionPainFeature PainFeature.Triggers), """I've noticed it seems to be worse when I look into the lights. That really sets it off.""")
    , (Question.toInt (QuestionPainFeature PainFeature.Timing), """The damn thing has been there for about an hour now. I really can't concentrate.""")
    , (Question.toInt (QuestionPainFeature PainFeature.Radiation), """It doesn't seem to go anywhere, no.""")
    , (Question.toInt (QuestionPainFeature PainFeature.Side), """I couldn't point to one side in particular.""")
    , (Question.toInt (QuestionPainFeature PainFeature.Where), """I feel it strongest at the back of my head, but it's everywhere. It feels like my head is bursting. """)
    , (Question.toInt (QuestionPainFeature PainFeature.Onset), """It started very suddenly just a few hours ago.""")
    , (Question.toInt (QuestionPainFeature PainFeature.Before), """Well I've had a couple of headaches in the past week. Nothing like this though.""")
    , (Question.toInt (QuestionPhx Phx.Surgery), """No, I've never had surgery before.""")
    , (Question.toInt (QuestionPhx Phx.Hypertension), """Yeah, my blood pressure's always been a bit high. I take a tablet for that though, I think it's called Coversyl.""")
    , (Question.toInt (QuestionPhx Phx.Diabetes), """Not me, no.""")
    , (Question.toInt (QuestionPhx Phx.Immunisation), """I think I've had them all. I mean, what should I be having? That's a rhetorical question, you don't have to answer. """)
    , (Question.toInt (QuestionShx Shx.Diet), """I eat takeaway quite a lot, especially at the sushi place just down the street. They've got some really good fusion sushi.""")
    , (Question.toInt (QuestionShx Shx.Driving), """I do drive, yes, but why do you ask?""")
    , (Question.toInt (QuestionShx Shx.LivingPeople), """I live with my husband and my two children.""")
    , (Question.toInt (QuestionShx Shx.Mood), """I've been stressed with a few of my clients this week, but honestly, who isn't. """)
    , (Question.toInt (QuestionShx Shx.PhysicalExercise), """The girls and I sometimes go down for a walk along the beach.""")
    , (Question.toInt (QuestionShx Shx.LivingPlace), """We live in a house near the beach. It's quite lovely.""")
    , (Question.toInt (QuestionSign Sign.Papilloedema), """Present.""")
    , (Question.toInt (QuestionSmoke Smoke.History), """Well I still smoke.""")
    , (Question.toInt (QuestionSmoke Smoke.Quantity), """About 10 cigarettes a day I'd say.""")
    , (Question.toInt (QuestionSmoke Smoke.Duration), """I've smoked on and off since my twenties.""")
    , (Question.toInt (QuestionSmoke Smoke.YesNo), """Yes, I do smoke.""")
    , (Question.toInt (QuestionSymptom Symptom.Photophobia), """Yes, the lights are terrible here. Why are they so bright?""")
    , (Question.toInt (QuestionSymptom Symptom.Diplopia), """Yes, I think I'm seeing double. Especially when I try looking to you on my left. I see two of your faces.""")
    , (Question.toInt (QuestionSymptom Symptom.Fatigue), """I mean, I'm always tired. Who isn't always tired?""")
    , (Question.toInt (QuestionSymptom Symptom.NeckStiff), """Yes, my neck does seem awfully stiff.""")
    , (Question.toInt (QuestionSymptom Symptom.Pain), """Yes, my headache. """)
    , (Question.toInt (QuestionSymptom Symptom.Loc), """Yes, I think I must have fainted at some point or something.""")
    , (Question.toInt (QuestionSymptom Symptom.VisualChange), """I think I'm seeing double. Especially when I try looking to you on my left. I see two of your faces.""")
    , (Question.toInt (QuestionSymptom Symptom.Headache), """Yes, I have a headache. Didn't I tell you that?""")
    , (Question.toInt (QuestionSymptomFeature SymptomFeature.When), """About an hour ago.""")
    , (Question.toInt (QuestionSymptomFeature SymptomFeature.Aggravating), """I really can't focus, I'm sorry. I'm not really sure.""")
    , (Question.toInt (QuestionSymptomFeature SymptomFeature.Quantity), """Terrible, I feel absolutely terrible.""")
    , (Question.toInt (QuestionSymptomFeature SymptomFeature.Alleviating), """Nothing.""")
    , (Question.toInt (QuestionFeelings Feelings.Expectations), """I just want to get rid of my bloody headache. It's really getting to me.""")
    , (Question.toInt (QuestionFeelings Feelings.Beliefs), """I have no idea.""")
    , (Question.toInt (QuestionFeelings Feelings.Impact), """I can't do anything with this headache. I can barely think straight.""")
    , (Question.toInt (QuestionFeelings Feelings.Concerns), """I hope there's a way to fix this.""") ]

details : Case.Details
details =
    { id = "margaret_smith_55_f_lawyer"
    , firstName = "Margaret"
    , lastName = "Smith"
    , age = 55
    , gender = Female
    , occupation = "Lawyer"
    , writer = "jwu202"
    , illustrator = "jyuu0055"
    }


patient : Case
patient =
    { details = details
    , script = script
    , stem = """# ED Referral Letter

Date: 03/04/2020

**Referred to**:  
Emergency Department  
The Royal St Queens Hospital

**Referred from**:  
Dr John Titor MBBS FRACGP  
Genericare Medical Practice  
15 Kongroo Street, GATEFORD, VIC 3000  
Phone: 9000 1234

**RE: Margaret Smith (DOB: 05/08/1964) **

---

Thank you for seeing Margaret Smith, a pleasant and high-functioning 55-year-old lady who came to my clinic this morning with a **severe headache**. She was unable to describe her symptoms to me clearly today and appeared in an acute state of distress. As her primary practitioner, this concerned me greatly given that Margaret is usually highly articulate. I have referred her to your service for urgent assessment and management. 

On examination today, her HR was 76bpm, BP 160/110, RR 14 and T 37C. There were no abnormal findings on neurological examination.

Her past medical history and usual medications are listed below.

## Past Medical History

| Condition | Year Diagnosed | Status |
|---|---|---|
| Asthma | 1996 | Active |
| Hypertension | 2009 | Active |
| GAD |2014 | Active |
| Contact dermatitis |2018 | Active |
| Myomectomy |2015 | Inactive |

## Medications

| Medication | Dosage | Route | Frequency |
|---|---|---|---|
|CHOLECALCIFEROL (VITAMIN D) |1000IU |Oral |Once daily|
|COVERSYL (PERINDOPRIL) |5mg | Oral |Once daily |
|SALBUTAMOL |100mcg |Inhaled| PRN t.i.d. |
|SERTRALINE |50mg | Oral | Once daily |

No allergies noted.

---

Thank you for your assistance. If you require any further information, please do not hesitate to contact Genericare Medical Practice. 

Kind regards,  
Dr John Titor MBBS FRACGP"""
    , openingGreeting = """Hey there Doc...My head is absolutely killing me. """
    , exemplarNote = """03/04/2020 12:47PM
ED HMO1 (P. Parker)

55F referred to ED via GP with sudden-onset severe headache. 

HoPC:
- Well at home until several hours prior to presentation when headache began.
- Sudden onset without precipitant. 
- Headache generalised, strongest at occiput.
- Pulsatile, 10/10, "worst headache in my life". 
- Associated with neck stiffness, photophobia, diplopia. 
- Nil head trauma, nausea/vomiting, fever, sick contacts.

PMHx: 
- Asthma
- Hypertension
- Anxiety

FHx: 
- Mother has PCKD, passed away from stroke in 50s.
- Two children, both well. 

Medications: 
- Perindopril 5mg po daily
- Sertraline 50mg po daily
- Salbutamol PRN 

Allergies:
Nil. 

Social Hx:
- Lives with husband and two children
- Employed as lawyer

O/E: 
- Lying tired in bed but able to converse.
- HR 90, BP 170/130, RR 18, T 37.2, SpO2 98% on room air.
- GCS 15
- PEARL 4.0mm
- CN III/IV/VI: Eye movements grossly normal, diplopia on lateral gaze
- Upper limb power 5/5, lower limb power 5/5. 
- Chest clear to auscultation. 

Impression: 
? Subarachnoid haemorrhage in setting of FHx PCKD and hypertension

Plan: 
1. 18G IV cannulae and draw bloods for FBE, UEC, aPTT, PT
2. Urgent non-contrast CT brain ? subarachnoid haemorrhage
3. Urgent neurosurgical referral 
4. Nimodipine 60mg PO q4h + analgesia + stool softener"""
    , exemplarDiagnosis = Subarachnoidhaemorrhage
    , exemplarPrescriptions =
        [{ medication = Nimodipine, dosage = "60mg", route = "PO", frequency = "q4h" }, { medication = Paracetamol, dosage = "1000mg", route = "PO", frequency = "PRN-q6h" }, { medication = Docusate, dosage = "500mg", route = "PO", frequency = "daily" }]
    , exemplarInvestigations =
        [InvestigationImaging CTBCTBrain, InvestigationBloods FBEFullBloodExamination, InvestigationBloods UECUreaElectrolytesandCreatinine, InvestigationBloods APTTActivatedpartialthromboplastintime, InvestigationBloods PTProthrombintime]
    , commentary = """Margaret has a **subarachnoid haemorrhage** (SAH). 

Subarachnoid haemorrhage refers to bleeding in the subarachnoid space, and is a **medical emergency**. If you do not treat subarachnoid haemorrhage, patients are at risk of **permanent neurological damage** (due to cerebral infarction), **shock** (due to bleeding) and **death** (due to both!). Subarachnoid haemorrhage usually occurs because of bleeding from an **aneurysm** in the brain: any condition which increases the risk of cerebral aneurysms (such as **polycystic kidney disease**) also increases the risk of subarachnoid haemorrhage. 

Subarachnoid haemorrhage is typically characterised by:

1. A **sudden-onset**, severe headache often described as like a **thunderclap** and 'the worst headache in my life'. This may often be the only finding. 
2. Altered mental state such as **reduced consciousness** or **loss of consciousness**.
3. **Meningismus** (signs usually associated with meningeal inflammation) including symptoms such as **neck stiffness** or **photophobia**. This can occur because blood breakdown products can irritate the meninges.
4. Sometimes **focal neurological deficits** due to cerebral ischaemia.
5. Sometimes diplopia, such as due to compression of the oculomotor nerve by an aneurysm.
6. **Sentinel headaches**, which are sudden severe headaches indicating small haemorrhages prior to rupture, or other changes such as thrombosis or dissection in the aneurysm.

**Any patient with a sudden-onset severe headache** should be suspected of SAH. 

Your management approach should be to **confirm SAH** and engage **early contact with the neurosurgical team** to secure a bleeding aneurysm.

1. Stabilise the patient using an ABC approach
2. Obtain an urgent non-contrast CT scan of the head to confirm SAH
3. Immediately consult with the neurosurgical team
4. Monitor frequently for deterioration in meantime (e.g. hourly neuro obs)
5. Provide analgesia for the patient's comfort (paracetamol or codeine would be appropriate)
6. Give **nimodipine**, a calcium-channel blocker which reduces the risk of vasospasm that could exacerbate cerebral ischaemia (with decent evidence behind its usage). Patients are sometimes also given "prophylactic" stool softeners to reduce straining, as this can induce fluctuations in blood pressure and bleeding. 
7. Control blood pressure, typically systolic between 110 and 160 mmHg, such as with IV labetalol. Don't go too low as cerebral perfusion pressure (CPP) may decrease and provoke cerebral ischaemia if mean arterial pressure drops too low. 

If the head CT is negative, then do a **lumbar puncture** if there is still significant clinical suspicion of SAH. The lumbar puncture will classicaly show **xanthochromia** (blood breakdown products in the CSF) in SAH."""
    }

