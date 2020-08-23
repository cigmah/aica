module App exposing (main)

import Browser
import Maker.Main as Maker


main : Program () Maker.Model Maker.Msg
main =
    Browser.element
        { view = Maker.view
        , init = Maker.init
        , update = Maker.update
        , subscriptions = Maker.subscriptions
        }
