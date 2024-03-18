{-# LANGUAGE TemplateHaskell #-}

module Page.Home where

import AppEnvironment
import Yesod

getHomeR :: Handler Html
getHomeR = defaultLayout $(whamletFile "templates/page-home.hamlet")