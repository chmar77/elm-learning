module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)


main =
    beginnerProgram
        { model = model
        , view = view
        , update = update
        }


type alias Model =
    { counterNum : Int
    , title : String
    , titleColor : String
    }


model : Model
model =
    { counterNum = 0
    , title = "Elm Learning"
    , titleColor = "black"
    }


type Msg
    = Increment
    | Decrement
    | ChangeTitleColorToBlue


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | counterNum = model.counterNum + 100 }

        -- return {title = "the same", counterNum = 100}
        Decrement ->
            { model | counterNum = model.counterNum - 1 }

        ChangeTitleColorToBlue ->
            { model | titleColor = "blue" }


view model =
    div []
        [ h1 [ style [ ( "color", model.titleColor ) ] ] [ text model.title ]
        , bootstrapTest
        , p [ class "my-own-style" ] [ text "This is my own style" ]
        , button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (toString model.counterNum) ]
        , button [ onClick Increment, id "plus-sign" ] [ text "+" ]
        , button [ onClick ChangeTitleColorToBlue ] [ text "Change Color" ]
        ]


bootstrapTest =
    div [ class "alert alert-primary", attribute "role" "alert" ]
        [ text "This is a primary alert—check it out!" ]
