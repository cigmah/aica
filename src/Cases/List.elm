
module Cases.List exposing (..)

import Cases.Case as Case exposing (Case)
import Cases.MargaretSmith55FLawyer as MargaretSmith55FLawyer

list : List Case
list = 
    [MargaretSmith55FLawyer.patient]

basicList : List Case.Details
basicList = 
    list
    |> List.map .details

