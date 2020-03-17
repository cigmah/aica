import generate_utils as utils
import pandas as pd

data = pd.read_csv("./diagnosis.csv", header=None)
unprocessed = list(data.iloc[:, 0])
output = utils.generate_enum("Diagnosis", unprocessed)

template = """module Diagnosis exposing (..)

import Option

{output}

"""

with open("../src/Diagnosis.elm", "w+") as outfile:
    outfile.write(template.format(output=output))

