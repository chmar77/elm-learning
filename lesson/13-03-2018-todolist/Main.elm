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
    , todoInput : AddTodo
    }


type alias TodoItem =
    { id : Int
    , value : String
    }


type alias AddTodo =
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
    , todoInput = { id = 0, value = "" }
    }


type Msg
    = AddNewTodo AddTodo
    | UserInput String
    | DeleteTodo Int
    | EditTodo TodoItem



-- Type Container : List
-- TodoItemList function addTodo (String newValue, TodoItemList todoListOld) {
--     dfiasjfiasjfi
--     return newTodoList
-- }


addTodo : String -> List TodoItem -> List TodoItem
addTodo newValue oldTodoList =
    let
        newTodoList =
            if (String.trim newValue) /= "" then
                [ { id = (List.length oldTodoList) + 1, value = newValue }
                ]
                    ++ oldTodoList
            else
                oldTodoList
    in
        newTodoList


editTodo : AddTodo -> List TodoItem -> List TodoItem
editTodo newTodo oldTodoList =
    let
        newTodoList =
            List.map
                (\oldTodo ->
                    if oldTodo.id == newTodo.id then
                        { oldTodo | value = newTodo.value }
                    else
                        oldTodo
                )
                oldTodoList
    in
        newTodoList


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddNewTodo newTodo ->
            let
                newTodoList =
                    if newTodo.id == 0 then
                        addTodo newTodo.value model.todoList
                    else
                        editTodo newTodo model.todoList
            in
                { model
                    | todoList = newTodoList
                    , todoInput = { id = 0, value = "" }
                }

        UserInput string ->
            let
                modelTodoInput =
                    model.todoInput

                newTodoInput =
                    { modelTodoInput | value = string }
            in
                { model | todoInput = newTodoInput }

        DeleteTodo deleteId ->
            let
                newTodoList =
                    List.filter
                        -- (\{ id, value } -> id /= deleteId)
                        (\todo -> todo.id /= deleteId)
                        model.todoList
            in
                { model | todoList = newTodoList }

        EditTodo todoItem ->
            { model
                | todoInput = todoItem
            }


view : Model -> Html Msg
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
        , button [ onClick (EditTodo todo) ] [ text "Edit" ]
        , button [ onClick (DeleteTodo todo.id) ] [ text "Delete" ]
        ]


newTodoView : AddTodo -> Html Msg
newTodoView todoInput =
    div []
        [ input
            [ placeholder "Enter text here"
            , value todoInput.value

            -- onInput accept a message that need a string
            , onInput UserInput
            ]
            []
        , if (todoInput.id == 0) then
            button [ onClick (AddNewTodo todoInput) ] [ text "Add" ]
          else
            button [ onClick (AddNewTodo todoInput) ] [ text "Edit" ]
        ]
