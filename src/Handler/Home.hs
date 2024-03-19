{-# LANGUAGE TemplateHaskell #-}

module Handler.Home where

import Foundation
import Yesod

getHomeR :: Handler Html
getHomeR = defaultLayout $ do
    setTitle "Home"
    $(whamletFile "templates/page-home.hamlet")