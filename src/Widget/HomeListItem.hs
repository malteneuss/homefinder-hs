{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE TemplateHaskell #-}

module Widget.HomeListItem where

import Data.Text (Text)
import Foundation (Widget)
import Yesod (whamletFile)

data HomeListItem = HomeListItem
    { imageUrl :: [Text]
    , title :: Text
    , address :: Text
    , roomCount :: Text
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
        { imageUrl = ["https://example.com/image.jpg"]
        , title = "Schönes Haus in den Vororten"
        , address = "123 Hauptstraße, 10007 Berlin"
        , roomCount = "4"
        , sqmLivingSpace = "150 sqm"
        , sqmPropertySpace = "300 sqm"
        , bedrooms = "3 beds"
        , bathrooms = "2 baths"
        , price = "500.000€"
        , details = "Geräumiger Hinterhof, moderne Küche"
        , originalSource = "<html> ....</html>"
        , sourceUrl = "https://example.com/listing/123"
        , firstFetchDate = "2022-01-01"
        , lastFetchDate = "2022-01-05"
        }

mkHomeListItemWidget :: HomeListItem -> Widget
mkHomeListItemWidget home = $(whamletFile "templates/widget-home-list-item.hamlet")