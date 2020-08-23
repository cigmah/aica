module Shared.Validating exposing (Validating(..), ValidationError)


type alias ValidationError =
    String


type Validating a
    = Valid a
    | Invalid (List ValidationError)
