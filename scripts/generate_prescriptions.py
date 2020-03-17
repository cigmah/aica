import generate_utils as utils
import pandas as pd

data = pd.read_csv("./prescriptions.csv", header=None)
unprocessed = list(data.iloc[:, 0])
output = utils.generate_enum("Prescription", unprocessed)

template = """module Prescription exposing (..)

import Option

{output}

"""

with open("../src/Prescription.elm", "w+") as outfile:
    outfile.write(template.format(output=output))
