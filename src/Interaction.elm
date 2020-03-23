module Interaction exposing (..)

import Array exposing (Array)
import Cases.Case as Case exposing (Case)
import Option
import Questions.Question as Question exposing (Question)


init : Case -> Interaction
init patient =
    { conversation = [] }


type Speaker
    = You
    | Me


type alias Item =
    { value : String
    , speaker : Speaker
    }


{-| Checks if speaker is you.
-}
isYou : Speaker -> Bool
isYou speaker =
    case speaker of
        You ->
            True

        Me ->
            False


{-| Checks if speaker is me.
-}
isMe : Speaker -> Bool
isMe speaker =
    case speaker of
        Me ->
            True

        You ->
            False


type alias Interaction =
    { conversation : List Item }


type alias Response =
    { readDelay : Int
    , writeDelay : Int
    , value : String
    }


{-| Initialise the first response queue
-}
initResponseQueue : Case -> List Response
initResponseQueue patient =
    [ createQueueItem "..." "Hi there Doc...I'm not feeling too good." ]


{-| Calculates the reading delay for a question. Using 1000 milliseconds per 40 characters.
-}
calculateReadDelay : String -> Int
calculateReadDelay string =
    String.length string * 25


{-| Calculates the writing delay for a question. Using 1000 milliseconds per 100 characters.
-}
calculateWriteDelay : String -> Int
calculateWriteDelay string =
    String.length string * 10


{-| Create a new response to be added to the response queue
-}
createQueueItem : String -> String -> Response
createQueueItem question answer =
    { readDelay = calculateReadDelay question
    , writeDelay = calculateWriteDelay answer
    , value = answer
    }


{-| Reduce the read delay by a number of milliseconds.
-}
reduceReadDelay : Int -> Response -> Response
reduceReadDelay millis ({ readDelay } as response) =
    { response | readDelay = readDelay - millis }


{-| Reduce the write delay by a number of milliseconds.
-}
reduceWriteDelay : Int -> Response -> Response
reduceWriteDelay millis ({ writeDelay } as response) =
    { response | writeDelay = writeDelay - millis }


{-| Add a response to the interaction
-}
addResponseToInteraction : Interaction -> Response -> Interaction
addResponseToInteraction ({ conversation } as interaction) { value } =
    { interaction | conversation = { value = value, speaker = You } :: conversation }


{-| Add a question to the interaction
-}
addQuestionToInteraction : Interaction -> String -> Interaction
addQuestionToInteraction ({ conversation } as interaction) question =
    { interaction | conversation = { value = question, speaker = Me } :: conversation }
