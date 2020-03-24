""" Utiltiies for generating Elm code files.

Code is being generated because a core part of the application is "information."
The information can be transformed into type-safe utilities so that errors can be caught at compile-time. 
This is especially the case for type enumerations. 
"""

from typing import List
import pandas as pd
import re
import string
import os

non_alpha = re.compile("[\W_]+")

ENUM_TEMPLATE = """

type {enum_name} = {enum_types}

fromInt : Int -> {enum_name}
fromInt int = 
    case int of
{enum_from_int}

toInt : {enum_name} -> Int
toInt enum = 
    case enum of 
{enum_to_int}

toString : {enum_name} -> String
toString enum = 
    case enum of
{enum_to_string}

list : List {enum_name}
list = 
{enum_list}

optionList : ({enum_name} -> String -> msg) -> List (Option.Data {enum_name} msg) 
optionList msg = 
{option_list}

"""


def process_string(string: str) -> str:
    """ Convert a string into a string safe to be used as an Elm type."""
    filtered = non_alpha.sub("", string)
    titled = filtered[:1].upper() + filtered[1:]
    return titled


def generate_enum_types(strings: List[str]) -> str:
    """ Convert list of (processed) enum types to a string to insert into the enum template to define tagged enum."""
    return "\n    | ".join(strings)


def generate_enum_from_int(strings: List[str]) -> str:
    """ Convert list of (processed) enum types to a string to insert into the enum template to convert ints to enum."""
    template = """        {i} -> {enum_type}"""
    templates = [
        template.format(i=i, enum_type=enum_type) for i, enum_type in enumerate(strings)
    ]
    templates.append(template.format(i="_", enum_type=strings[0]))
    return "\n".join(templates)


def generate_enum_to_int(strings: List[str]) -> str:
    """ Convert list of (processed) enum types to a string to insert into the enum template to convert enum into ints."""
    template = """        {enum_type} -> {i}"""
    templates = [
        template.format(i=i, enum_type=enum_type) for i, enum_type in enumerate(strings)
    ]
    return "\n".join(templates)


def generate_enum_list(strings: List[str]) -> str:
    """ Convert list of (processed) enum types to a string to insert into the enum template to define enum list of values """
    return "    [ " + "\n    , ".join(strings) + " ]"


def generate_enum_to_string(unprocessed: List[str], processed: List[str]) -> str:
    """ Convert list of unprocessed & processed enum types to a string to insert into the enum template to convert enum to string"""
    template = """        {enum_type} -> \"{enum_string}\""""
    templates = [
        template.format(enum_type=enum_type, enum_string=enum_string)
        for (enum_string, enum_type) in zip(unprocessed, processed)
    ]
    return "\n".join(templates)


OPTION_TEMPLATE = """{{ value = {value}, string = "{option_string}", onClick = msg ({value}) "{option_string}", tags = "{tags}" }}"""


def generate_option_list(unprocessed: List[str], processed: List[str]) -> str:
    """ Generate option list from processed enum types."""
    templates = []
    for u, p in zip(unprocessed, processed):
        value = p
        string = u
        tags = ""
        templates.append(
            OPTION_TEMPLATE.format(value=value, option_string=string, tags=tags)
        )
    return "    [ " + "\n    , ".join(templates) + " ]"


def generate_enum(enum_name: str, unprocessed: List[str]) -> str:
    """ Generate a simple enum from a list of strings."""
    processed = [process_string(s) for s in unprocessed]
    enum_types = generate_enum_types(processed)
    enum_from_int = generate_enum_from_int(processed)
    enum_to_int = generate_enum_to_int(processed)
    enum_list = generate_enum_list(processed)
    enum_to_string = generate_enum_to_string(unprocessed, processed)
    option_list = generate_option_list(unprocessed, processed)
    output = ENUM_TEMPLATE.format(
        enum_name=enum_name,
        enum_types=enum_types,
        enum_from_int=enum_from_int,
        enum_to_int=enum_to_int,
        enum_list=enum_list,
        enum_to_string=enum_to_string,
        option_list=option_list,
    )
    return output


CHILD_ENUM_TEMPLATE = """module {directory}.{enum_name} exposing (..)

type {enum_name} = {enum_types}

"""

PARENT_ENUM_TEMPLATE = """module {directory}.{parent_enum} exposing (..)

import Option
import Array exposing (Array)

{enum_imports}

type {parent_enum} = {parent_enum_types}

fromInt : Int -> {parent_enum}
fromInt int = 
    case int of
{enum_from_int}

toInt : {parent_enum} -> Int
toInt enum = 
    case enum of 
{enum_to_int}

toString : {parent_enum} -> String
toString enum = 
    case enum of
{enum_to_string}

list : List {parent_enum}
list = 
{enum_list}

optionList : ({parent_enum} -> String -> msg) -> List (Option.Data {parent_enum} msg)
optionList msg =
{option_list}

"""


def generate_enum_imports(parent_enum: str, enum_types: List[str]) -> str:
    """ Convert list of processed enum to imports for parent enum"""
    template = "import {parent_enum}.{enum_type} as {enum_type} exposing (..)"
    templates = [
        template.format(parent_enum=parent_enum, enum_type=enum_type)
        for enum_type in enum_types
    ]
    return "\n".join(templates)


def generate_option_list_with_parent(parent_enum: str, data: pd.DataFrame) -> str:
    """ Generate option list from data with category, subcategory, option_string and tags columns."""
    templates = []
    for _, row in data.iterrows():
        enum_name = process_string(row.category)
        value = (
            parent_enum
            + enum_name
            + " "
            + enum_name
            + "."
            + process_string(row.subcategory)
        )
        string = row.option_string
        if row.tags:
            tags = row.tags
        else:
            tags = ""
        templates.append(
            OPTION_TEMPLATE.format(value=value, option_string=string, tags=tags)
        )
    return "    [ " + "\n    , ".join(templates) + " ]"


def save_parent_child_enum(
    data: pd.DataFrame, parent_enum: str, directory: str, directory_path: str
) -> None:
    """ Generates and saves parent and child double enum. Ensure data has columns category, subcategory, string, option_string, tags."""
    children = []
    parent_enum_types = []
    unique_pairs = []
    pairs = []
    strings = []
    # Generate the children first
    # Loop through every parent category
    for category in data.category.unique():
        # Subset the category to find the children
        subset = data[data.category == category]
        # Generate the child enum name
        enum_name = process_string(category)
        enum_types = [
            process_string(subcategory) for subcategory in subset.subcategory.unique()
        ]
        child_output = CHILD_ENUM_TEMPLATE.format(
            directory=directory,
            enum_name=enum_name,
            enum_types=generate_enum_types(enum_types),
        )
        # Save the child enum
        filepath = os.path.join(directory_path, enum_name + ".elm")
        with open(filepath, "w+") as outfile:
            outfile.write(child_output)
        # Append enum name to children list
        children.append(enum_name)
        # Append enum and pairs to pairs
        pairs += [
            parent_enum + enum_name + " " + enum_name + "." + enum_type
            for enum_type in enum_types
        ]
        # Append strings
        strings += list(subset.string)
        # Append parent enum type
        parent_enum_types.append(parent_enum + enum_name + " " + enum_name)

    enum_imports = generate_enum_imports(directory, children)
    enum_from_int = generate_enum_from_int(pairs)
    enum_to_int = generate_enum_to_int(pairs)
    enum_list = generate_enum_list(pairs)
    enum_to_string = generate_enum_to_string(strings, pairs)
    option_list = generate_option_list_with_parent(parent_enum, data)

    # Format the parent enum template
    parent_output = PARENT_ENUM_TEMPLATE.format(
        directory=directory,
        parent_enum=parent_enum,
        parent_enum_types=generate_enum_types(parent_enum_types),
        enum_imports=enum_imports,
        enum_from_int=enum_from_int,
        enum_to_int=enum_to_int,
        enum_list=enum_list,
        enum_to_string=enum_to_string,
        option_list=option_list,
    )

    parent_filepath = os.path.join(directory_path, parent_enum + ".elm")
    with open(parent_filepath, "w+") as outfile:
        outfile.write(parent_output)
