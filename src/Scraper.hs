{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE OverloadedStrings #-}

module Scraper where

import Data.Map qualified as Map
import Data.Text (Text)

-- Justizportal Zwangsversteigerungen Deutschland
data ZvgInfo = ZvgInfo
    { title :: Text
    , entryUrl :: Text
    }
    deriving stock (Show)

zvgInfo :: ZvgInfo
zvgInfo =
    ZvgInfo
        { title = "Justizportal Zwangsversteigerungen Deutschland"
        , entryUrl = "https://www.zvg-portal.de/index.php?button=Suchen"
        }

-- To see home listings we have search and provide
-- select a bundesland (state).
stateSelectionFormName :: Text
stateSelectionFormName = "land_abk"
stateSelectionOptions :: [(Text, Text)]
stateSelectionOptions =
    [ ("0", "-- Bitte Bundesland auswählen --")
    , ("bw", "Baden-Wuerttemberg")
    , ("by", "Bayern")
    , ("be", "Berlin")
    , ("br", "Brandenburg")
    , ("hb", "Bremen")
    , ("hh", "Hamburg")
    , ("he", "Hessen")
    , ("mv", "Mecklenburg-Vorpommern")
    , ("ni", "Niedersachsen")
    , ("nw", "Nordrhein-Westfalen")
    , ("rp", "Rheinland-Pfalz")
    , ("sl", "Saarland")
    , ("sn", "Sachsen")
    , ("st", "Sachsen-Anhalt")
    , ("sh", "Schleswig-Holstein")
    , ("th", "Thüringen")
    ]

zvgSearchFormData :: Text -> Map.Map Text Text
zvgSearchFormData stateSelection =
    Map.fromList
        [ ("ger_name", "--+Alle+Amtsgerichte+--")
        , ("order_by", "2")
        , ("land_abk", stateSelection)
        , ("ger_id", "0")
        , ("az1", "")
        , ("az2", "")
        , ("az3", "")
        , ("az4", "")
        , ("art", "")
        , ("obj", "")
        , ("str", "")
        , ("hnr", "")
        , ("plz", "")
        , ("ort", "")
        , ("ortsteil", "")
        , ("vtermin", "")
        , ("btermin", "")
        ]
