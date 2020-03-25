import pandas as pd


def run_generate_case_template():
    data = pd.read_csv("./questions.csv", header=0)
    pairs = list(set(zip(data.category, data.subcategory)))
    pairs.sort(key=lambda x: x[0])

    template = pd.DataFrame(columns=["category", "subcategory"])

    additional = [
        ("core", "firstName"),
        ("core", "lastName"),
        ("core", "age"),
        ("core", "gender"),
        ("core", "stem"),
        ("core", "occupation"),
        ("core", "openingGreeting"),
        ("answer", "exemplarNote"),
        ("answer", "exemplarDiagnosis"),
        (
            "answer",
            "exemplarInvestigations",
        ),  # to be expressed as "|" separate list of strings e.g. FBE | UEC | LFT
        (
            "answer",
            "exemplarPrescriptions",
        ),  # to be expressed as "|" separated list of strings e.g. Aspirin 300mg po stat
        ("answer", "commentary"),
    ]

    for (c, s) in additional:
        template = template.append({"category": c, "subcategory": s}, ignore_index=True)

    for (c, s) in pairs:
        template = template.append({"category": c, "subcategory": s}, ignore_index=True)

    template.to_csv("./case_template.csv", header=False, index=False)
