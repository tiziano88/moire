import Html
import Html.Attributes as Html
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
    [ Html.a
      [ Html.href "https://github.com/tiziano88/moire" ]
      [ Html.img
        [ Html.style [("position", "absolute"), ("top", "0"), ("left", "0"), ("border", "0")]
        , Html.src "https://camo.githubusercontent.com/82b228a3648bf44fc1163ef44c62fcc60081495e/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f6c6566745f7265645f6161303030302e706e67" ]
        , Html.alt "Fork me on GitHub" ]
        []
      ]
    , Svg.svg
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
    , Html.text "test"
    ]
