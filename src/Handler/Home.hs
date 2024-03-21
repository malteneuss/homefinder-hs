{-# LANGUAGE TemplateHaskell #-}

module Handler.Home where

import Foundation
import Widget.HomeListItem
import Yesod

getHomeR :: Handler Html
getHomeR = defaultLayout $ do
    setTitle "Homes"
    let homeListItems = replicate 10 $ mkHomeListItemWidget fakeHomeListItem
    $(whamletFile "templates/page-home.hamlet")