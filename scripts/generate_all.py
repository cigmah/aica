""" Generate all required code files from csv files. Run this from the scripts directory. """

from generate_case_template import run_generate_case_template
from generate_cases import run_generate_cases
from generate_diagnosis import run_generate_diagnosis
from generate_investigations import run_generate_investigations
from generate_medications import run_generate_medications
from generate_questions import run_generate_questions

run_generate_case_template()
run_generate_cases()
run_generate_diagnosis()
run_generate_investigations()
run_generate_medications()
run_generate_questions()
