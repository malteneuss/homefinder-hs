{-# LANGUAGE TemplateHaskell #-}

module Handler.Home where

import Foundation
import Widget.HomeListItem
import Yesod

getHomeR :: Handler Html
getHomeR = defaultLayout $ do
    setTitle "Homes"

    let homeListItems = fmap mkHomeListItemWidget $ concat $ replicate 5 [fakeHomeListItem, fakeHomeListItem2]
    $(whamletFile "templates/page-home.hamlet")

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

fakeHomeListItem2 :: HomeListItem
fakeHomeListItem2 =
    HomeListItem
        { imageUrl = Just "/static/test/test-home-2.webp"
        , title = "Gemütliches Haus am See"
        , address = "456 Seestraße, 20008 Berlin"
        , rooms = "5 Zimmer"
        , sqmLivingSpace = "200 qm"
        , sqmPropertySpace = "400 qm"
        , bedrooms = "4 Bettzimmer"
        , bathrooms = "3 Badezimmer"
        , price = "600.000€"
        , details = "Großer Garten, Kamin"
        , originalSource = "<html> ....</html>"
        , sourceUrl = "https://example.com/listing/456"
        , firstFetchDate = "seit 2022-03-01"
        , lastFetchDate = "vom 2022-04-10"
        }
        