module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- Model


type alias Model =
    { content : String
    , total : Int
    , source : String
    }


model : Model
model =
    { content = ""
    , source = ""
    , total = 0
    }



-- Update


type Msg
    = AddCalorie
    | Clear
    | Change
    | AddFromInput String


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddCalorie ->
            { model | total = model.total + 1 }

        Clear ->
            { model | total = 0 }

        Change ->
            case String.toInt model.source of
                Err msg ->
                    { model | total = model.total }

                Ok content ->
                    { model | total = model.total + content, source = "" }

        AddFromInput source ->
            { model | source = source }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h3 []
            [ text ("Total calories: " ++ (toString model.total)) ]
        , button [ type_ "button", onClick AddCalorie ] [ text "Add" ]
        , button [ type_ "button", onClick Clear ] [ text "Clear" ]
        , br [] []
        , br [] []
        , input [ type_ "text", placeholder "Text to reverse", onInput AddFromInput, value model.source ]
            []
        , button [ type_ "button", onClick Change ] [ text "Add" ]
        ]
