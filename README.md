# AICA

An Interactive Case Archive, or AICA, consists of a number of interactive medical cases for revision. 

Early work in progress.

# Build CSS

Currently using `tailwindcss` for functional component styles and `purgecss` to reduce css size. 

Run:

```
npm run build-css
```

# Important Note on Code Generation

To save on boilerplate, some of the Elm code is generated using Python scripts. 

The `Question`, `Investigation`, `Diagnosis` and `Medication` types are all currently generated from `.csv` files located in `scripts`. 

To regenerate the types and related functions:

1. `cd ./scripts` from the home directory
2. Make additions and edits as required to the `questions.csv`, `investigations.csv`, `diagnosis.csv`, or `medications.csv` files.
3. `python ./generate_questions.py` or `python ./generate_investigations.py` or `python ./generate_diagnosis.py` or `python ./generate_medications.py` as required. `pandas` must be installed.

Once the code is generated, any breaking changes will throw a compile error on the next attempt to build or run the app.
