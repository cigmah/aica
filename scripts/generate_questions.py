import generate_utils as utils
import pandas as pd

data = pd.read_csv("./questions.csv", header=0)
data["string"] = data.subcategory

utils.save_parent_child_enum(data, "Question", "Questions", "../src/Questions/")

