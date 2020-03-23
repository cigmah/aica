import generate_utils as utils
import pandas as pd


def run_generate_medications():
    data = pd.read_csv("./medications.csv", header=None)
    unprocessed = list(data.iloc[:, 0])
    output = utils.generate_enum("Medication", unprocessed)

    template = """module Medication exposing (..)

import Option

{output}

"""

    with open("../src/Medication.elm", "w+") as outfile:
        outfile.write(template.format(output=output))
