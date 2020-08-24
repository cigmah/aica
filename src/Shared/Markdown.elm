module Shared.Markdown exposing (toHtml, toHtmlSafe)

import Html exposing (Html)
import Html.Attributes exposing (class)
import Markdown


toHtml : String -> Html msg
toHtml =
    Markdown.toHtmlWith
        { githubFlavored = Just { tables = True, breaks = True }
        , defaultHighlighting = Nothing
        , sanitize = False
        , smartypants = False
        }
        [ class "markdown" ]


toHtmlSafe : String -> Html msg
toHtmlSafe =
    Markdown.toHtmlWith
        { githubFlavored = Just { tables = True, breaks = True }
        , defaultHighlighting = Nothing
        , sanitize = True
        , smartypants = False
        }
        [ class "markdown" ]
