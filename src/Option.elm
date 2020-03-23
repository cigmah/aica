module Option exposing (..)


type alias Data value msg =
    { value : value
    , string : String
    , onClick : msg
    , tags : String
    }
