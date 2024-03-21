{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE TemplateHaskell #-}

module Widget.HomeListItem where

import Data.Text (Text)
import Foundation (Widget)
import Yesod (whamletFile)

data HomeListItem = HomeListItem
    { imageUrl :: Maybe Text
    , title :: Text
    , address :: Text
    , rooms :: Text
    , sqmLivingSpace :: Text
    , sqmPropertySpace :: Text
    , bedrooms :: Text
    , bathrooms :: Text
    , price :: Text
    , details :: Text
    , originalSource :: Text
    , sourceUrl :: Text
    , firstFetchDate :: Text
    , lastFetchDate :: Text
    }

fakeHomeListItem :: HomeListItem
fakeHomeListItem =
    HomeListItem
        { imageUrl = Just "/static/test/test-home-1.webp"
        , title = "Schönes Haus in den Vororten"
        , address = "123 Hauptstraße, 10007 Berlin"
        , rooms = "4 Zimmer"
        , sqmLivingSpace = "150 qm"
        , sqmPropertySpace = "300 qm"
        , bedrooms = "3 Bettzimmer"
        , bathrooms = "2 Badezimmer"
        , price = "500.000€"
        , details = "Geräumiger Hinterhof, moderne Küche"
        , originalSource = "<html> ....</html>"
        , sourceUrl = "https://example.com/listing/123"
        , firstFetchDate = "seit 2022-01-01"
        , lastFetchDate = "vom 2022-02-05"
        }

mkHomeListItemWidget :: HomeListItem -> Widget
mkHomeListItemWidget home = $(whamletFile "templates/widget-home-list-item.hamlet")