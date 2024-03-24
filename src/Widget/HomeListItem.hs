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
    , rooms :: Maybe Int
    , sqmLivingSpace :: Maybe Int
    , sqmPropertySpace :: Maybe Int
    , bedrooms :: Maybe Int
    , bathrooms :: Maybe Int
    , price :: Maybe Int
    , details :: Text
    , originalSource :: Text
    , sourceUrl :: Text
    , lastFetchDate :: Text
    }

mkHomeListItemWidget :: HomeListItem -> Widget
mkHomeListItemWidget home = $(whamletFile "templates/widget-home-list-item.hamlet")