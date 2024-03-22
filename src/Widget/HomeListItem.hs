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


mkHomeListItemWidget :: HomeListItem -> Widget
mkHomeListItemWidget home = $(whamletFile "templates/widget-home-list-item.hamlet")