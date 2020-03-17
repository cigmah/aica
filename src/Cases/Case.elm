module Cases.Case exposing (..)

{-| Type definitions for interactive medical cases.
-}

import Time exposing (Posix)


{-| Patient genders
-}
type Gender
    = Male
    | Female
    | Other String


{-| A brief is a single noun.
-}
type Brief
    = Brief String


{-| A description is a more extensive description.
-}
type Description
    = Descriptor String


{-| Rough occupation types
-}
type Occupation
    = Employed Brief Description -- job and description
    | Student Brief Description -- area of study and description
    | Unemployed Description -- description of past employment
    | Retired Description -- description of past employment


{-| Basic patient details.
-}
type alias Details =
    { firstName : String
    , lastName : String
    , dob : Posix
    , gender : Gender
    , occupation : Occupation
    }


type alias Case =
    { details : Details
    , 
    }
