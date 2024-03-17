{-# LANGUAGE QuasiQuotes #-}

module Page.Home where

import AppEnvironment
import Yesod

-- The handler for the GET request at /, corresponds to HomeR.
getHomeR :: Handler Html
getHomeR = defaultLayout [whamlet|Hello World!|]