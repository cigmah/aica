module Option exposing (..)


type alias Data value msg =
    { value : value
    , string : String
    , onClick : value -> msg
    , tags : String
    }
