
module Cases.List exposing (..)

import Cases.Case as Case exposing (Case)
import Cases.MargaretSmith55FLawyer as MargaretSmith55FLawyer
import Cases.LarryBole63MElectrician as LarryBole63MElectrician
import Cases.GregorySanders54MBanker as GregorySanders54MBanker

list : List Case
list = 
    [MargaretSmith55FLawyer.patient, LarryBole63MElectrician.patient, GregorySanders54MBanker.patient]

basicList : List Case.Details
basicList = 
    list
    |> List.map .details

