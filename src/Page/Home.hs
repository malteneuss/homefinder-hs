{-# LANGUAGE TemplateHaskell #-}

module Page.Home where

import AppEnvironment
import Yesod
import Widget.Navbar (navbar)

getHomeR :: Handler Html
getHomeR = defaultLayout $ do
    navbar
    $(whamletFile "templates/page-home.hamlet")