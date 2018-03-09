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
    { title : String
    , todoList : List TodoItem
    , todoInput : String
    }


type alias TodoItem =
    { id : Int
    , value : String
    }


model : Model
model =
    { title = "Todo List"
    , todoList =
        [ { id = 1, value = "Some data" }
        , { id = 2, value = "Some data 2" }
        , { id = 3, value = "Some data 3" }
        ]
    , todoInput = ""
    }


type Msg
    = AddNewTodo String
    | UserInput String
    | DeleteTodo Int



-- Type Container : List


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddNewTodo newTodo ->
            let
                newTodoList =
                    if (String.trim newTodo) /= "" then
                        [ { id = (List.length model.todoList) + 1
                          , value = newTodo
                          }
                        ]
                            ++ model.todoList
                    else
                        model.todoList
            in
                { model
                    | todoList = newTodoList
                    , todoInput = ""
                }

        UserInput string ->
            { model | todoInput = string }

        DeleteTodo deleteId ->
            let
                newTodoList =
                    List.filter
                        (\{ id, value } -> id /= deleteId)
                        model.todoList
            in
                { model | todoList = newTodoList }



-- \oldTodo -> oldTodo /= string
-- string =
--     "sth"
-- isTodoTheSame oldTodo =
--     oldTodo /= string


view model =
    div []
        [ h1 [] [ text model.title ]
        , todoListView model.todoList
        , newTodoView model.todoInput
        ]


todoListView : List TodoItem -> Html Msg
todoListView todoList =
    ul []
        (List.map todoItemView todoList)


todoItemView : TodoItem -> Html Msg
todoItemView todo =
    li []
        [ text todo.value
        , button [ onClick (DeleteTodo todo.id) ] [ text "Delete" ]
        ]



-- todoListData =
--     [ "Todo list 1"
--     , "Todo list 2"
--     , "Todo list 5"
--     ]


newTodoView todoInput =
    div []
        [ input
            [ placeholder "Enter text here"
            , value todoInput

            -- onInput accept a message that need a string
            , onInput UserInput
            ]
            []
        , button [ onClick (AddNewTodo todoInput) ] [ text "Add" ]
        ]
