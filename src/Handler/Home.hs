{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Use 'fromMaybe' from Relude" #-}
{-# HLINT ignore "Use toText" #-}

module Handler.Home where

import DB.Model (Home (..))
import Data.Text as T
import Data.Time.Clock (UTCTime)
import Data.Time.Format (defaultTimeLocale, formatTime)
import Foundation ( Handler )
import Widget.HomeListItem
import Yesod

getHomeR :: Handler Html
getHomeR = do
    -- add a db query to get all homes
    homes :: [Entity Home] <- runDB $ selectList [] []
    let homeListItems = fmap mkHomeListItemWidget $ toHomeListItem <$> fmap entityVal homes
    defaultLayout $ do
        setTitle "Homes"
        $(whamletFile "templates/page-home.hamlet")

toHomeListItem :: Home -> HomeListItem
toHomeListItem home =
    HomeListItem
        { imageUrl = Just "/static/test/test-home-1.webp"
        , title = home.title
        , address = home.address
        , rooms = home.rooms
        , sqmLivingSpace = home.sqmLivingSpace
        , sqmPropertySpace = home.sqmPropertySpace
        , bedrooms = home.bedrooms
        , bathrooms = home.bathrooms
        , price = home.price
        , details = home.details
        , originalSource = home.originalSource
        , sourceUrl = home.sourceUrl
        , lastFetchDate = formatDate home.lastFetchDate
        }

formatDate :: UTCTime -> Text
formatDate = T.pack . formatTime defaultTimeLocale "%Y-%m-%d"