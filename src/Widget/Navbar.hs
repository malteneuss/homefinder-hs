{-# LANGUAGE TemplateHaskell #-}

module Page.Home where

import AppEnvironment
import Yesod

getHomeR :: Widget
getHomeR = $(whamletFile "src/templates/widget-navbar.xhamlet")