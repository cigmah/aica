
module Cases.LarryBole63MElectrician exposing (..)

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
import Questions.Feelings as Feelings exposing (..)
import Questions.Fhx as Fhx exposing (..)
import Questions.LocFeature as LocFeature exposing (..)
import Questions.Open as Open exposing (..)
import Questions.PainFeature as PainFeature exposing (..)
import Questions.Phx as Phx exposing (..)
import Questions.Shx as Shx exposing (..)
import Questions.Smoke as Smoke exposing (..)
import Questions.Symptom as Symptom exposing (..)
import Questions.SymptomFeature as SymptomFeature exposing (..)
import Questions.DyspnoeaFeature as DyspnoeaFeature exposing (..)
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
                    "Seems grossly normal. But you might need to be more specific."

                QuestionSign _ ->
                    "No abnormality detected."

                _ ->
                    "I'm not sure."

scriptDict : Dict Int String
scriptDict = Dict.fromList 
    [ (Question.toInt (QuestionAlcohol Alcohol.YesNo), """Oh yeah definitely.""")
    , (Question.toInt (QuestionAlcohol Alcohol.Quantity), """Maybe a stubbie or two every night. Bout the only thing to look forward to nowadays. """)
    , (Question.toInt (QuestionDetails Details.Dob), """23rd January 1957.""")
    , (Question.toInt (QuestionDetails Details.OccupationBrief), """I work as an electrician.""")
    , (Question.toInt (QuestionDetails Details.Age), """I'm 63.""")
    , (Question.toInt (QuestionDetails Details.Name), """Larry Bole.""")
    , (Question.toInt (QuestionDetails Details.OccupationDescription), """I do some electrical work, but not been doing much of that nowadays. Been staying inside like we're supposed to.""")
    , (Question.toInt (QuestionDrugs Drugs.Regular), """I've got the Januvia and the Diabex I take every day, then there's the Nor-something for my pressure. I've got a cream too, it's got a name like Elephant or something. """)
    , (Question.toInt (QuestionDrugs Drugs.Allergies), """My GP gave me something for my pressure once. I think I was allergic, it gave me a bit of a cough.""")
    , (Question.toInt (QuestionDrugs Drugs.Otc), """No I don't take anything else.""")
    , (Question.toInt (QuestionDrugs Drugs.Recreational), """Nah.""")
    , (Question.toInt (QuestionExamine Examine.Rash), """You notice a small salmon-pink rash on the left thigh with silvery scale.""")
    , (Question.toInt (QuestionExamine Examine.HeartAuscultate), """You hear an ejection systolic murmur at the right upper sternal border. It radiates to the carotids. """)
    , (Question.toInt (QuestionExamine Examine.Hands), """Worn but otherwise normal.""")
    , (Question.toInt (QuestionExamine Examine.MentalState), """Larry is friendly and jocular. His speech is regular in rate and normal in volume. He reports he his happy. He looks happy with an appropriate range of affect. There is no indication of formal thought disorder or perceptual abnormalities. His cognition and judgement are grossly intact.""")
    , (Question.toInt (QuestionExamine Examine.LungsAuscultate), """Normal vesicular breath sounds all over the chest. No crepitations.""")
    , (Question.toInt (QuestionExamine Examine.GCS), """He's sitting and talking to you. He walked into the clinic by himself.""")
    , (Question.toInt (QuestionExamine Examine.Weight), """Larry weighs 92kg.""")
    , (Question.toInt (QuestionExamine Examine.Height), """Larry is 179cm tall.""")
    , (Question.toInt (QuestionExamine Examine.Nails), """They are worn in places but otherwise normal.""")
    , (Question.toInt (QuestionExamine Examine.Vitals), """HR 80bpm regular, BP 128/78, RR 20bpm, T 37.1C.""")
    , (Question.toInt (QuestionExamine Examine.General), """Larry is sitting in the chair across your desk calmly. He is slightly overweight.""")
    , (Question.toInt (QuestionExamine Examine.Surroundings), """It's your own clinic room. Larry is looking at you quizically as you look around the room intently.""")
    , (Question.toInt (QuestionExamine Examine.Arms), """Some small waxy flat-topped lesions on right arm, about 2cm diameter. Well-circumscribed.""")
    , (Question.toInt (QuestionExamine Examine.Oxygen), """98% on room air.""")
    , (Question.toInt (QuestionExamine Examine.ECG), """You don't have an ECG in the clinic unfortunately.""")
    , (Question.toInt (QuestionFeelings Feelings.Concerns), """I dunno if this is normal or not, I just don't really like it. """)
    , (Question.toInt (QuestionFeelings Feelings.Impact), """Our house has two storeys, and our bedroom's on the top floor. It's a bit of a workout getting up there, let me tell you.""")
    , (Question.toInt (QuestionFeelings Feelings.Beliefs), """Maybe I'm just getting old. I hope it's not the coronavirus!""")
    , (Question.toInt (QuestionFeelings Feelings.Expectations), """Just hoping to get something done about this puffiness.""")
    , (Question.toInt (QuestionFhx Fhx.Siblings), """Nah, I don't have any siblings.""")
    , (Question.toInt (QuestionFhx Fhx.SiblingsHealth), """I'm an only child.""")
    , (Question.toInt (QuestionFhx Fhx.Children), """Yeah I got three kids. """)
    , (Question.toInt (QuestionFhx Fhx.ChildrenHealth), """My kids are all pretty healthy.""")
    , (Question.toInt (QuestionFhx Fhx.ParentHealth), """Mom and dad are still going okay. Dad's got some Alzheimer's but mom keeps him going. """)
    , (Question.toInt (QuestionLocFeature LocFeature.When), """It's only happened like once, when I was walking up all those stairs about a month ago. Got really puffed. """)
    , (Question.toInt (QuestionOpen Open.Phx), """Nahh, not really. Got a bit of diabetes but I think that's about it.""")
    , (Question.toInt (QuestionOpen Open.Fhx), """I think my dad had some heart troubles. """)
    , (Question.toInt (QuestionOpen Open.More), """Well it all started maybe half a year ago. I used to be able to walk okay, but since then I've been getting more puffed on my way to work. Had a few times when I think I almost fainted.""")
    , (Question.toInt (QuestionOpen Open.Opening), """Well I've been getting a bit puffed out of the past few months. Never was very fit, but it's been getting real bad recently.""")
    , (Question.toInt (QuestionOpen Open.Symptoms), """Uhhmm..not sure off the top of my head. Maybe you could ask me some specifically.""")
    , (Question.toInt (QuestionOpen Open.Greeting), """Yeah, nice to meet ya too. Hope you're doing okay, I heard on the news the other night that the docs are really under the pump right now. """)
    , (Question.toInt (QuestionPainFeature PainFeature.Quantity), """Maybe like a 4 outta 10?""")
    , (Question.toInt (QuestionPainFeature PainFeature.Quality), """Hard to describe. Just feels like a pain.""")
    , (Question.toInt (QuestionPainFeature PainFeature.Triggers), """Walking up the stairs will do it.""")
    , (Question.toInt (QuestionPainFeature PainFeature.Radiation), """Nah, not really.""")
    , (Question.toInt (QuestionPainFeature PainFeature.Where), """Sometimes I get it in my chest when I go up the stairs. Just in the middle (points to heart). """)
    , (Question.toInt (QuestionPhx Phx.Immunisation), """I think so. I've had all the ones as a kid.""")
    , (Question.toInt (QuestionPhx Phx.Surgery), """Nah, never had surgery before. Aren't I lucky!""")
    , (Question.toInt (QuestionPhx Phx.Diabetes), """Yeah I got diabetes.""")
    , (Question.toInt (QuestionPhx Phx.DiabetesType), """I don't know what type. It's the one where I take tablets, I got two tablets for that. Januvia and Diabex. """)
    , (Question.toInt (QuestionPhx Phx.Hypertension), """Yeah, my pressure's always been a bit high. I take a tablet for that - Nor-something? """)
    , (Question.toInt (QuestionShx Shx.Driving), """Yeah, course I do. Can barely do anything without a car nowadays. Wouldn't want to take the trains now either. """)
    , (Question.toInt (QuestionShx Shx.Mood), """I've been alright, but the whole world is going bonkers. Last week it was toilet paper, this week it was beef. What'll it be next?""")
    , (Question.toInt (QuestionShx Shx.LivingPeople), """Live with my wife. My kids moved out ages ago, they're all adults now and doing their own thing.""")
    , (Question.toInt (QuestionShx Shx.PhysicalExercise), """Nah, don't do much of that nowadays. I get too puffed out.""")
    , (Question.toInt (QuestionShx Shx.Diet), """We used to eat out a lot, but haven't done much o' that last week. My wife's been cooking up a lot of pasta, spaghetti and that type of thing. """)
    , (Question.toInt (QuestionShx Shx.LivingPlace), """I live with my wife in North Array, just by the Array River.""")
    , (Question.toInt (QuestionShx Shx.Hobbies), """Usually watch a bit of the footy with some mates. I'm a Mondrich Lions supporter, don't tell me you go for the Magpies!""")
    , (Question.toInt (QuestionShx Shx.GP), """Used to see Dr Malone at Holisticare Clinic, but they've closed up. Never really liked them anyway, I reckon I'll probably come here from now on.""")
    , (Question.toInt (QuestionSmoke Smoke.Quantity), """Oh not much. Maybe one or two cigs a day.""")
    , (Question.toInt (QuestionSmoke Smoke.Duration), """Maybe 20 years or so.""")
    , (Question.toInt (QuestionSmoke Smoke.History), """Yeah, I still do.""")
    , (Question.toInt (QuestionSmoke Smoke.YesNo), """Yeah, I smoke. Just a bit though.""")
    , (Question.toInt (QuestionSymptom Symptom.SickContact), """I haven't been out of the house for about a week, except for the odd groceries here and there. Barely see anyone nowadays, it's like a ghost town. """)
    , (Question.toInt (QuestionSymptom Symptom.Cough), """No, none of that. I would have stayed home and called ahead if I did! I know the drill.""")
    , (Question.toInt (QuestionSymptom Symptom.Fatigue), """Nothing different to the usual. Used to have a bit of trouble sleeping but not much anymore.""")
    , (Question.toInt (QuestionSymptom Symptom.Dyspnoea), """Yeah, short of breath a lot. It's been really bothering me. """)
    , (Question.toInt (QuestionSymptom Symptom.ChestPain), """You know, sometimes I do get a bit of a twinge in the chest when I go up the stairs. It goes away after I stop and rest though.""")
    , (Question.toInt (QuestionSymptom Symptom.Pain), """Not usually, no.""")
    , (Question.toInt (QuestionSymptom Symptom.Loc), """There was one time when I was walking up a real long flight of stairs, when I felt like I was gonna pass out at the very top. Lucky my wife was there, she caught me real quick and got me to rest on the floor a bit. It was okay after that.""")
    , (Question.toInt (QuestionSymptomFeature SymptomFeature.Aggravating), """It only seems to come on when I try and exert meself. """)
    , (Question.toInt (QuestionSymptomFeature SymptomFeature.Alleviating), """I come good when I sit down.""")
    , (Question.toInt (QuestionSymptomFeature SymptomFeature.When), """It's been for a while now, maybe about five or six months. """)
    , (Question.toInt (QuestionSymptomFeature SymptomFeature.Quantity), """It was okay at first, but it's been slowly getting worse. Now I can't really walk up three or four steps without getting a bit puffed.""")
    , (Question.toInt (QuestionDyspnoeaFeature DyspnoeaFeature.Precipitants), """I used to be able to walk up the stairs no issue about five months ago, but now I feel puffed going up about three or four steps. """) ]

details : Case.Details
details =
    { id = "larry_bole_63_m_electrician"
    , firstName = "Larry"
    , lastName = "Bole"
    , age = 63
    , gender = Male
    , occupation = "Electrician"
    , writer = "jwu202"
    , illustrator = "jyuu0055"
    }


patient : Case
patient =
    { details = details
    , script = script
    , stem = """# GP Clinic Appointment

Date: 03/04/2020  
Time: 14:04

You are a **GP Registrar** at Genericare Medical Practice starting the afternoon clinic appointments. It's a rainy day in the midst of a pandemic, and a Friday too. 

Your first afternoon appointment is with **Larry Bole**, a **63 year old gentleman** scheduled for a 15-minute appointment. It's his first visit to Genericare Medical Practice, and he has filled in the following first-visit paperwork. The transfer of medical records from the last clinic Larry attended has been delayed. 

**Please see Larry for his appointment and address any of his concerns**. 

## First-Visit Documentation

### Patient Details

| Field | Value |
|---|---|
| Title | MR  |
| Name | Larry Matthew Bole|
| Date of Birth |23/01/1957  |
| Gender | Male |
| Occupation | Electrician  | 
| Marital Status | Married  | 
| Country of Birth | Australia  | 
| Do you identify as Aboriginal or Torres Strait Islander? | No |

### Past Medical History 

*Do you have or have you had any of the following conditions? *

| Condition | Response | 
|---|---|
| Asthma | No |
| Diabetes | Yes | 
| Hypertension | Yes | 
| Chronic illness | No |
| Other | N/A |

*Please list any medications you currently take.*

- Norvasc
- Diabex
- Januvia
- Eleuphrat cream

*Are all your immunisations up to date?* Yes.

*When was your last:*

- *Colorectal cancer screening?* Last year
- *(Women) Breast cancer screening?* N/A
- *(Women) Cervical cancer screening?* N/A"""
    , openingGreeting = """G'day Doc, how are ya? Weather outside's not lookin' too good. Almost didn't come but I've been really wanting to see a doc recently and my usual clinic's closed down 'cos of the Coronavirus!"""
    , exemplarNote = """03/04/2020 02:14PM
GP Registrar (T. Stark)

63M first visit to clinic, presenting with progressive SOBOE. 

SOBOE approx 6/12 duration, tolerating 3-4 stair steps only.
Associated with chest pain on exertion and one episode weakness ? presyncope.
Nil acute chest pain, cough, wheeze, fever, PND, orthopnoea, ankle swelling. 

Awaiting transfer of medical records - for long-term care here.
PHx of HTN, NIIDM, psoriasis. 
Currently taking amlodipine, metformin, sitagliptin, topical corticosteroid. 
Nil allergies.
Works as electrician, lives with wife. 

O/E:
HR 80bpm regular, BP 128/78, RR 20bpm, T 37.1C. SpO2 98% on room air.
Systolic ejection murmur on right parasternal border radiating to carotids.
Lungs clear. 
Flat waxy lesions on right arm.

Impression: 
? symptomatic aortic stenosis for investigation. 
For long-term cardiac risk management and diabetes cycle of care.

Plan: 
1. Referral to cardiologist for suspected aortic stenosis ? valvular function ? replacement candidate
2. CV risk assessment and diabetes follow-up for new patient - FBE, UEC, LFT, lipid panel, HbA1C.
3. Review CV risk and initiate diabetes cycle of care next week after transfer of medical records. Advised to contact for urgent appointment or visit ED if SOB or chest pain at rest. """
    , exemplarDiagnosis = Aorticstenosis
    , exemplarPrescriptions =
        []
    , exemplarInvestigations =
        [InvestigationOther ECGElectrocardiogram, InvestigationOther Echocardiogram, InvestigationBloods FBEFullBloodExamination, InvestigationBloods UECUreaElectrolytesandCreatinine, InvestigationBloods Hba1c, InvestigationBloods Lipids, InvestigationBloods LFTLiverFunctionTests]
    , commentary = """Larry is experiencing **symptomatic aortic stenosis**. 

**Aortic stenosis** (AS) refers to reduced ventricular outflow through the aortic valve. This can occur due to damage of the aortic valve (such as from inflammation from rheumatic heart disease) or gradual calcification of the valve, which often occurs progressively with age. Risk factors include **rheumatic heart disease**, a **bicuspid aortic valve**, **advanced age**, **connective tissue diseases**, and smoking, hypertension and diabetes. 

The "classic" triad of aortic stenosis can be remembered with the mnemonic **SAD**:

1. **Syncope** on exertion, due to reduced blood flow through the valve,
2. **Angina** (chest pain on exertion), due to myocardial ischaemia (which may stem from greater LV oxygen demand, or reduced coronary perfusion). 
3. **Dyspnoea** on exertion, which may present as reduced exercise tolerance. 

Aortic stenosis is very often asymptomatic, and merely picked up as an incidental finding on cardiac examination. Many patients with AS also have underlying coronary artery disease, which may present with typical IHD symptoms. 

**Echocardiography** is the primary diagnostic test for AS and to assess for left ventricular outflow and other cardiac abnormalities. An ECG is not diagnostic, but often shows associated changes such as left ventricular hypertrophy. 

Asymptomatic patients may not require specific therapy for AS, but would benefit from cardiovascular risk reduction and other preventive therapies. The definitive treatment for healthy patients with severe symptomatic AS is surgical valve replacement. You can organise this through referral to an appropriate cardiology service.

What else can we do for Larry? Given that Larry has expressed an interest in being a patient long-term at Genericare, we can also focus on preventive activities for his prominent cardiac risk factors. We should evaluate his cardiac risk and obtain a set of relevant blood tests to assess his cardiac risk and diabetes control. We should also begin to think about initiating management through the diabetes cycle of care, including managing his weight, diet, physical activity and ophthalmic health. Finally, in the meantime between this and his next visit, we should provide appropriate safety-netting in case his condition worsens, particularly given his cardiac risk factors. """
    }

