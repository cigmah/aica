module Element.EditPreviousNotes exposing (Data, view)

import Element.ButtonGhost
import Element.Tailwind exposing (..)
import Element.TextArea
import Element.TextInput
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Shared.Markdown as Markdown
import Shared.Note as Note exposing (Note)
import Shared.Patient as Patient exposing (..)


type alias Data msg =
    { patient : Patient.InProgress
    , newNote : Note
    , onChangeNewDate : String -> msg
    , onChangeNewBrief : String -> msg
    , onChangeNewFull : String -> msg
    , onAddNote : msg
    , onDeleteNote : Note -> msg
    }


displayNoteItem : (Note -> msg) -> Note -> Html msg
displayNoteItem onDelete note =
    details
        [ tailwind "w-full border-b" ]
        [ summary
            [ tailwind "flex w-full hover:cursor-pointer hover:bg-gray-100 focus:bg-gray-100" ]
            [ div [ tailwind "mr-4 p-2" ] [ text note.date ]
            , div [ tailwind "flex-grow font-bold p-2" ] [ text note.brief ]
            , button
                [ tailwind "flex-end bg-red-500 text-white font-bold text-sm p-2 px-4 flex align-center items-center hover:bg-red-400 active:bg-red-600"
                , onClick (onDelete note)
                ]
                [ text "Delete" ]
            ]
        , pre [ style "white-space" "pre-wrap", tailwind "p-4 text-sm bg-gray-200" ]
            [ text note.full ]
        ]


view : Data msg -> Html msg
view data =
    section []
        [ section
            [ tailwind "flex flex-col" ]
            [ label
                [ tailwind "text-sm font-bold m-1" ]
                [ text "New Clinical Note" ]
            , section
                [ tailwind "flex" ]
                [ article
                    [ tailwind "w-full" ]
                    [ Element.TextInput.view
                        { label = "Date of Clinical Note"
                        , type_ = "date"
                        , value = data.newNote.date
                        , placeholder = "2020-02-25"
                        , onChange = data.onChangeNewDate
                        , disabled = False
                        }
                    , Element.TextInput.view
                        { label = "Clinical Note Description"
                        , type_ = "text"
                        , value = data.newNote.brief
                        , placeholder = "e.g. External GP Letter"
                        , onChange = data.onChangeNewBrief
                        , disabled = False
                        }
                    , Element.TextArea.view
                        { label = "Clinical Note"
                        , value = data.newNote.full
                        , rows = 10
                        , onInput = data.onChangeNewFull
                        , disabled = False
                        , placeholder = "Enter the full clinical note here."
                        }
                    ]
                , article
                    [ tailwind "w-full ml-4 m-1 flex-grow flex flex-col" ]
                    [ label [ tailwind "text-xs text-bold text-grey-600 mb-1" ]
                        [ text "Clinical Note Preview" ]
                    , article [ tailwind "p-4 border flex-grow" ]
                        [ h1
                            [ tailwind "flex text-sm mb-4" ]
                            [ div [ tailwind "font-bold mr-4" ] [ text "Entered on: " ]
                            , div [] [ text data.newNote.date ]
                            ]
                        , h1
                            [ tailwind "font-bold mb-4 text-xl" ]
                            [ text data.newNote.brief ]
                        , section
                            [ tailwind "" ]
                            [ Markdown.toHtml data.newNote.full ]
                        ]
                    ]
                ]
            ]
        , Element.ButtonGhost.view
            { text = "Add Clinical Note"
            , onClick = data.onAddNote
            , type_ = "button"
            , disabled = False
            }
        , h1 [ tailwind "text-sm font-bold m-1 mt-4 mb-2" ] [ text "Added Clinical Notes" ]
        , section
            [ tailwind "border-t" ]
            (List.map (displayNoteItem data.onDeleteNote) data.patient.previousNotes)
        ]
