{-# LANGUAGE TemplateHaskell #-}

module Page.Home where

import Foundation
import Widget.Navbar (navbar)
import Yesod

getHomeR :: Handler Html
getHomeR = defaultLayout $ do
    setTitle "Home"
    navbar
    $(whamletFile "templates/page-home.hamlet")