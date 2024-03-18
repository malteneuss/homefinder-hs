{-# LANGUAGE TemplateHaskell #-}

module Page.Home where

import AppEnvironment
import Yesod

getHomeR :: Handler Html
getHomeR = defaultLayout $(whamletFile "src/templates/page-home.xhamlet")