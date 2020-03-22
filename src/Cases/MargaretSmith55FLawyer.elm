module Cases.MargaretSmith55FLawyer exposing (..)

import Array exposing (..)
import Cases.Case as Case exposing (..)
import Diagnosis exposing (..)
import Dict
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
import Questions.Question as Question exposing (..)
import Questions.Shx as Shx exposing (..)
import Questions.Sign as Sign exposing (..)
import Questions.Smoke as Smoke exposing (..)
import Questions.Symptom as Symptom exposing (..)
import Questions.SymptomFeature as SymptomFeature exposing (..)
import Set exposing (Set)


script : Question -> Set Question -> String
script question asked =
    case question of
        QuestionAlcohol Alcohol.Quantity ->
            "Oh I'd say I'm just an occasional drinker. A glass of wine occasionally at night, that sort of thing. "

        QuestionAlcohol Alcohol.YesNo ->
            "A little bit, yes."

        QuestionDetails Details.OccupationBrief ->
            "I work as a solicitor. It's a fine job. "

        QuestionDetails Details.Age ->
            "I'm 55 years old. Goodness, I'm getting old!"

        QuestionDetails Details.Name ->
            "My name's Margaret Smith. Pleasure to meet you."

        QuestionDetails Details.OccupationDescription ->
            "It's mostly office work, though sometimes it does get very stressful. My clients often have very high expectations you know!"

        QuestionDrugs Drugs.Recreational ->
            "Oh no, I would never take recreational drugs. "

        QuestionDrugs Drugs.Regular ->
            "I'm not on anything, no."

        QuestionDrugs Drugs.Otc ->
            "Oh I take a multivitamin every day. Just the ones you get from the supermarket. "

        QuestionDrugs Drugs.Allergies ->
            "Not that I know of."

        QuestionExamine Examine.General ->
            "You see a middle-aged lady with normal body habitus in bed, looking tired but conscious. "

        QuestionExamine Examine.Weight ->
            "Margaret currently weighs 64kg."

        QuestionExamine Examine.EyeMovements ->
            "The left eye does not abduct. Other eye movements are normal."

        QuestionExamine Examine.Vitals ->
            "HR 90bpm, BP 170/130, RR 18, T 37.2"

        QuestionExamine Examine.Fundus ->
            "The optic disc looks a bit swollen."

        QuestionExamine Examine.Surroundings ->
            "There's a book on the table. "

        QuestionExamine Examine.MentalState ->
            "You notice Margaret appears somewhat distractible. She scores 22/30 on an MMSE, losing points for serial sevens (1/5), recall (1/3) and three-stage command (1/3)."

        QuestionFhx Fhx.Siblings ->
            "I have an older brother and a younger sister. "

        QuestionFhx Fhx.Children ->
            "I've got a daughter, she's 20, and a son, he's 12. "

        QuestionFhx Fhx.ChildrenHealth ->
            "My children are fairly well. My youngest had asthma for a while, but that went away."

        QuestionFhx Fhx.ParentHealth ->
            "My mom had some problem with her kidneys. Something like polycystic kidney disease? She passed away from a stroke in her 50s. My dad's still with us though, he's going strong."

        QuestionFhx Fhx.SiblingsHealth ->
            "I think they're okay. I don�t talk to them much."

        QuestionLocFeature LocFeature.When ->
            "It was just a bit earlier today. I don't know how long I was out for, but it couldn't have been too long."

        QuestionOpen Open.Symptoms ->
            "My head's a bit fuzzy at the moment, could you name some sympoms? "

        QuestionOpen Open.Fhx ->
            "Well what would you like to know?"

        QuestionOpen Open.Phx ->
            "I think I've got high blood pressure or something like that. "

        QuestionOpen Open.Opening ->
            "Well, I've got this absolutely terrible headache. Really terrible."

        QuestionPainFeature PainFeature.Quality ->
            "It sort of feels like a thumping."

        QuestionPainFeature PainFeature.Quantity ->
            "It's 10/10. I mean, I've had headaches before but this is something else - definitely the worst headache of my life."

        QuestionPainFeature PainFeature.Triggers ->
            "I've noticed it seems to be worse when I look into the lights. That really sets it off."

        QuestionPainFeature PainFeature.Timing ->
            "The damn thing has been there for about an hour now. I really can't concentrate. "

        QuestionPainFeature PainFeature.Radiation ->
            "It doesn't seem to go anywhere, no."

        QuestionPainFeature PainFeature.Side ->
            "I couldn't point to one side in particular."

        QuestionPainFeature PainFeature.Where ->
            "I feel it strongest at the back of my head, but it's everywhere. It feels like my head is bursting. "

        QuestionPainFeature PainFeature.Onset ->
            "It started very suddenly just a few hours ago."

        QuestionPainFeature PainFeature.Before ->
            "Well I've had a couple of headaches in the past week. Nothing like this though."

        QuestionPhx Phx.Surgery ->
            "No, I've never had surgery before."

        QuestionPhx Phx.Hypertension ->
            "Nope."

        QuestionPhx Phx.Diabetes ->
            "Not me, no."

        QuestionPhx Phx.Immunisation ->
            "I think I've had them all. I mean, what should I be having? That's a rhetorical question, you don't have to answer. "

        QuestionShx Shx.Diet ->
            "I eat takeaway quite a lot, especially at the sushi place just down the street. They've got some really good fusion sushi."

        QuestionShx Shx.Driving ->
            "I do drive, yes, but why do you ask?"

        QuestionShx Shx.LivingPeople ->
            "I live with my husband and my two children."

        QuestionShx Shx.Mood ->
            "I've been stressed with a few of my clients this week, but honestly, who isn't. "

        QuestionShx Shx.PhysicalExercise ->
            "The girls and I sometimes go down for a walk along the beach. "

        QuestionShx Shx.LivingPlace ->
            "We live in a house near the beach. It's quite lovely."

        QuestionSign Sign.Papilloedema ->
            "Present."

        QuestionSmoke Smoke.History ->
            "Well I still smoke."

        QuestionSmoke Smoke.Quantity ->
            "About 10 cigarettes a day I'd say."

        QuestionSmoke Smoke.Duration ->
            "I've smoked on and off since my twenties."

        QuestionSmoke Smoke.YesNo ->
            "Yes, I do smoke."

        QuestionSymptom Symptom.Photophobia ->
            "Yes, the lights are terrible here. Why are they so bright?"

        QuestionSymptom Symptom.Diplopia ->
            "Yes, I think I'm seeing double. Especially when I try looking to you on my left. I see two of your faces."

        QuestionSymptom Symptom.Fatigue ->
            "I mean, I'm always tired. Who isn't always tired?"

        QuestionSymptom Symptom.NeckStiff ->
            "Yes, my neck does seem awfully stiff."

        QuestionSymptom Symptom.Pain ->
            "Yes, my headache. "

        QuestionSymptom Symptom.Loc ->
            "Yes, I think I must have fainted at some point or something."

        QuestionSymptom Symptom.VisualChange ->
            "I think I'm seeing double. Especially when I try looking to you on my left. I see two of your faces."

        QuestionSymptom Symptom.Headache ->
            "Yes, I have a headache. Didn't I tell you that?"

        QuestionSymptomFeature SymptomFeature.Where ->
            "In my head mostly."

        QuestionSymptomFeature SymptomFeature.Aggravating ->
            "I really can't focus, I'm sorry. I'm not really sure."

        QuestionSymptomFeature SymptomFeature.Quantity ->
            "Terrible, I feel absolutely terrible."

        QuestionSymptomFeature SymptomFeature.Alleviating ->
            "Nothing."

        QuestionFeelings Feelings.Expectations ->
            "I just want to get rid of my bloody headache. It's really getting to me."

        QuestionFeelings Feelings.Beliefs ->
            "I have no idea. "

        QuestionFeelings Feelings.Impact ->
            "I can't do anything with this headache. I can barely think straight."

        QuestionFeelings Feelings.Concerns ->
            "I hope there's a way to fix this. "

        QuestionSymptom _ ->
            "No."

        QuestionExamine _ ->
            "It seems grossly normal."

        QuestionSign _ ->
            "It seems normal."

        _ ->
            "Sorry, I'm not sure."


details : Case.Details
details =
    { id = 0
    , firstName = "Margaret"
    , lastName = "Smith"
    , age = 55
    , gender = Female
    , occupation = "Lawyer"
    }


patient : Case
patient =
    { details = details
    , script = script
    , exemplarNote = "Presented to ED with sudden-onset severe headache on b/g HTN and FHx of PCKD.\n \n HOPC:\n - Severe 10/10 headache onset several hours ago\n -\n \n PMHx:\n - HTN\n \n FHx:\n - Mother had PCKD, passed away from stroke in 50s\n \n Medications\n "
    , exemplarDiagnosis = Subarachnoidhaemorrhage
    , exemplarPrescriptions =
        Array.fromList
            [ { medication = Aspirin, dosage = "300mg", route = "po", frequency = "mane" } ]
    , exemplarInvestigations =
        Array.fromList
            [ InvestigationBloods FBE, InvestigationImaging CTBrain ]
    , commentary = "This is some sample commentary on the case and needs to be modified. "
    }
