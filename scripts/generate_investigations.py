import generate_utils as utils
import pandas as pd


def run_generate_investigations():
    data = pd.read_csv(
        "./investigations.csv", header=None, names=["category", "subcategory"]
    )
    data["string"] = data.subcategory
    data["tags"] = ""
    data["option_string"] = data.subcategory

    utils.save_parent_child_enum(
        data, "Investigation", "Investigations", "../src/Investigations/"
    )
