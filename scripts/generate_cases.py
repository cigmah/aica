""" Cases are stored in the `./cases` directory. Run this script from the scripts directory. 

TODO: Maybe change the case match expression to a Dict for lower complexity if performance suffers. 
Advantage of the function approach is that the previously asked set can be used as a parameter for responses,
but haven't implemented this anyway so might not be necessary.

"""

import pandas as pd
import generate_utils as utils
import os
from glob import glob
from collections import defaultdict
from typing import List, Dict

TEMPLATE = '''
module Cases.{name} exposing (..)

import Array exposing (..)
import Cases.Case as Case exposing (..)
import Diagnosis exposing (..)
import Investigations.Bloods exposing (..)
import Investigations.Imaging exposing (..)
import Investigations.Investigation as Investigation exposing (..)
import Investigations.Other exposing (..)
import Medication exposing (..)
import Prescription exposing (..)
{question_imports}
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
    {script_dict}

details : Case.Details
details =
    {{ id = "{patient_id}"
    , firstName = "{first_name}"
    , lastName = "{last_name}"
    , age = {age}
    , gender = {gender}
    , occupation = "{occupation}"
    , writer = "{writer}"
    , illustrator = "{illustrator}"
    }}


patient : Case
patient =
    {{ details = details
    , script = script
    , stem = """{stem}"""
    , openingGreeting = """{opening_greeting}"""
    , exemplarNote = """{exemplar_note}"""
    , exemplarDiagnosis = {exemplar_diagnosis}
    , exemplarPrescriptions =
        {exemplar_prescriptions}
    , exemplarInvestigations =
        {exemplar_investigations}
    , commentary = """{commentary}"""
    }}

'''


def generate_question_imports(categories: List[str]) -> str:
    """ Generate question type imports for file ."""
    import_template = "import Questions.{category} as {category} exposing (..)"
    return "\n".join([import_template.format(category=c) for c in categories])


def generate_script_case(category: str, subcategory: str, value: str) -> str:
    """ Generate a single case for the script function. """
    case_template = (
        '''(Question.toInt ({parent_enum} {category}.{subcategory}), """{value}""")'''
    )
    parent_enum = "Question" + category
    return case_template.format(
        parent_enum=parent_enum,
        category=category,
        subcategory=subcategory,
        value=value,
    )


def generate_script_cases(data_dict, categories: List[str]) -> str:
    """ Generate all case strings from a nested dictionary, with categories beginning with upper case letter. """
    case_lines = []
    for category in categories:
        subcategory_dict = data_dict[category]
        for subcategory, value in subcategory_dict.items():
            case_lines.append(generate_script_case(category, subcategory, value))
    return "[ " + "\n    , ".join(case_lines) + " ]"


def process_exemplar_investigations(investigation_string: str) -> str:
    """ Processes an exemplar investigation string. Short-term temporary measure until better solution for encoding these..."""
    investigations_separated = map(lambda s: s.strip(), investigation_string.split("|"))
    investigations = []
    for i in investigations_separated:
        i_split = i.split()
        cat = "Investigation" + i_split[0]
        subcat = i_split[1]
        investigations.append(cat + " " + subcat)
    return "[" + ", ".join(investigations) + "]"


def process_exemplar_prescriptions(prescriptions_string: str) -> str:
    """ Processes an exemplar prescriptions string. Short-term temporary measure until better solution for encoding these..."""
    prescr_separated = map(lambda s: s.strip(), prescriptions_string.split("|"))
    prescriptions = []
    prescr_template = """{{ medication = {med}, dosage = "{dose}", route = "{route}", frequency = "{freq}" }}"""
    for p in prescr_separated:
        [med, dose, route, freq] = p.split()
        formatted = prescr_template.format(med=med, dose=dose, route=route, freq=freq)
        prescriptions.append(formatted)
    return "[" + ", ".join(prescriptions) + "]"


def process_gender(gender_string: str) -> str:
    """ Process gender string into gender type."""
    genders = {"F": "Female", "M": "Male"}
    if gender_string.upper() in genders.keys():
        gender = genders[gender_string.upper()]
    else:
        gender = gender_string
    return gender


def generate_case(case_file, data):
    """ Generate case from data dict with category as keys, and subcategory dicts as values. Case_file is the filename of the case, used as its ID."""
    name = utils.process_string(data["core"]["firstName"] + data["core"]["lastName"])
    patient_id = case_file.split("/")[-1].split("\\")[-1].strip(".csv")
    gender_string = data["core"]["gender"]
    stem = data["core"]["stem"]
    question_categories = [k for k in data.keys() if k[0].isupper()]
    question_imports = generate_question_imports(question_categories)
    script_cases = generate_script_cases(data, question_categories)

    first_name = data["core"]["firstName"]
    last_name = data["core"]["lastName"]
    age = data["core"]["age"]
    gender = process_gender(gender_string)
    occupation = data["core"]["occupation"].title()
    opening_greeting = data["core"]["openingGreeting"]
    writer = data["core"]["writer"]
    illustrator = data["core"]["illustrator"]

    filename = "{name}{age}{gender_string}{occupation}".format(
        name=name, age=str(age), gender_string=gender_string, occupation=occupation,
    )

    exemplar_note = data["answer"]["exemplarNote"]
    exemplar_diagnosis = utils.process_string(data["answer"]["exemplarDiagnosis"])
    exemplar_investigations = process_exemplar_investigations(
        data["answer"]["exemplarInvestigations"]
    )
    exemplar_prescriptions = process_exemplar_prescriptions(
        data["answer"]["exemplarPrescriptions"]
    )
    commentary = data["answer"]["commentary"]

    output = TEMPLATE.format(
        name=filename,
        question_imports=question_imports,
        script_dict=script_cases,
        patient_id=patient_id,
        first_name=first_name,
        last_name=last_name,
        age=age,
        gender=gender,
        occupation=occupation,
        writer=writer,
        illustrator=illustrator,
        opening_greeting=opening_greeting,
        stem=stem,
        exemplar_note=exemplar_note,
        exemplar_diagnosis=exemplar_diagnosis,
        exemplar_investigations=exemplar_investigations,
        exemplar_prescriptions=exemplar_prescriptions,
        commentary=commentary,
    )

    return (filename, output)


# Process data into nested dictionary
def dfToDict(df):
    """ Converts pandas dataframe with keys category, subcategory, value into nested defaultdict."""
    data = defaultdict(dict)
    for _, row in df.iterrows():
        if row.category in data.keys():
            data[row.category][row.subcategory] = row.value
        else:
            data[row.category] = defaultdict(str)
            data[row.category][row.subcategory] = row.value
    return data


def generate_case_import(cases: List[str]) -> str:
    """ Generate the case import lines for the list of cases. """
    import_template = "import Cases.{name} as {name}"
    return "\n".join(import_template.format(name=name) for name in cases)


def generate_case_list(cases: List[str]) -> str:
    """ Generate the case list for the list of cases."""
    case_template = "{name}.patient"
    return "[" + ", ".join(case_template.format(name=name) for name in cases) + "]"


CASE_LIST_TEMPLATE = """
module Cases.List exposing (..)

import Cases.Case as Case exposing (Case)
{case_imports}

list : List Case
list = 
    {case_list}

basicList : List Case.Details
basicList = 
    list
    |> List.map .details

"""


def generate_case_list_file(cases: List[str]) -> str:
    return CASE_LIST_TEMPLATE.format(
        case_imports=generate_case_import(cases), case_list=generate_case_list(cases),
    )


def run_generate_cases():
    " Run the generate cases function and script."
    cases = []

    case_files = glob("./cases/*.csv")
    case_files.sort(key=os.path.getmtime)
    case_ids = []
    for _, case_file in enumerate(case_files):
        df = pd.read_csv(
            case_file,
            header=None,
            names=["category", "subcategory", "value"],
            encoding="ISO-8859-1",
        )
        data = dfToDict(df)
        filename, output = generate_case(case_file, data)
        cases.append(filename)
        case_ids.append(data["core"]["id"])
        with open(
            "../src/Cases/{filename}.elm".format(filename=filename), "wb"
        ) as outfile:
            outfile.write(output.encode("utf-8"))

    # Assert that all case ids are unique
    assert len(set(case_ids)) == len(case_ids)

    with open("../src/Cases/List.elm", "w") as outfile:
        outfile.write(generate_case_list_file(cases))
