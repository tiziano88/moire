import Html
import Html.App
import Svg
import Svg.Attributes as S
import Time


type alias Model =
  { tick : Int }


type Msg
  = Tick Time.Time


main = Html.App.program
  { init = init
  , update = update
  , subscriptions = \_ -> Time.every (20 * Time.millisecond) Tick
  , view = view
  }


init = ({tick = 0}, Cmd.none)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Nop -> (model, Cmd.none)
    Tick _ -> ({ model | tick = model.tick + 1 }, Cmd.none)


h = 1000


verticalLine x w =
  Svg.rect [ S.x (toString x), S.y (toString (-h)), S.width (toString w), S.height (toString (h * 2)) ] []


pattern s w =
  List.map
    (\x -> verticalLine ((s+w) * x) w)
    [-200..200]


view model =
  Html.div
    []
    [ Svg.svg
      [ S.width <| toString h
      , S.height <| toString h
      ]
      [ Svg.g
        [ S.transform "translate(500, 500)" ]
        [ Svg.g
          [ S.width <| toString h
          , S.height <| toString h
          , S.transform <| "rotate(" ++ (toString (toFloat model.tick)) ++ ")"
          ]
          (pattern 4 2)
        , Svg.g
          [ S.width <| toString h
          , S.height <| toString h
          ]
          (pattern 4 2)
        ]
      ]
    , Html.text (toString model)
    ]
