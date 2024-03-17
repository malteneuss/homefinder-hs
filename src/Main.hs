{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# OPTIONS_GHC -Wno-missing-deriving-strategies #-}

module Main where

import Yesod
  ( Html,
    RenderRoute (renderRoute),
    Yesod (defaultLayout),
    mkYesod,
    parseRoutes,
    warp,
    whamlet,
  )

data App = App
  {
  }

-- Add any fields you want to store in your foundation type here.
-- appSettings :: AppSettings
--  , appLogger :: Logger
--  , appStatic :: Static
--  , appConnectionPool :: ConnectionPool

-- Derive routes and instances for App.
mkYesod
  "App"
  [parseRoutes|
/ HomeR GET
|]

instance Yesod App -- Methods in here can be overridden as needed.

-- The handler for the GET request at /, corresponds to HomeR.
getHomeR :: Handler Html
getHomeR = defaultLayout [whamlet|Hello World!|]

main :: IO ()
main = warp 3000 App
