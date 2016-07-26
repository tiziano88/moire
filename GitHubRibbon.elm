module GitHubRibbon exposing
  ( view
  , Position (..)
  , Colour (..)
  )

import Html
import Html.Attributes as Html


type Position
  = Left
  | Right


type Colour
  = Red
  | Green
  | DarkBlue
  | Orange
  | Gray
  | White


-- Ref: https://github.com/blog/273-github-ribbons


view : Position -> Colour -> String -> Html.Html a
view pos col link =
  Html.a
    [ Html.href link ]
    [ Html.img
      [ Html.style <| style pos
      , Html.src <| img pos col
      , Html.alt "Fork me on GitHub" ]
      []
    ]


style : Position -> List (String, String)
style pos =
  let side =
    case pos of
      Left -> ("left", "0")
      Right -> ("right", "0")
  in
    [ ("position", "absolute")
    , ("top", "0")
    , ("border", "0")
    , side
    ]


img : Position -> Colour -> String
img pos col =
  let
    p = case pos of
      Left -> "left"
      Right -> "right"
    c1 = case col of
      Red -> "red"
      Green -> "green"
      DarkBlue -> "darkblue"
      Orange -> "orange"
      Gray -> "gray"
      White -> "white"
    c2 = case col of
      Red -> "aa0000"
      Green -> "007200"
      DarkBlue -> "121621"
      Orange -> "ff7600"
      Gray -> "6d6d6d"
      White -> "ffffff"
  in "https://s3.amazonaws.com/github/ribbons/forkme_" ++ p ++ "_" ++ c1 ++ "_" ++ c2 ++ ".png"

