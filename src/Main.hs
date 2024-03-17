{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# OPTIONS_GHC -Wno-missing-deriving-strategies #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module Main where

import AppEnvironment
import Page.Home
import Yesod

mkYesodDispatch "AppEnvironment" $(parseRoutesFile "src/routes.yesodroutes")

-- Add any fields you want to store in your foundation type here.
-- appSettings :: AppSettings
--  , appLogger :: Logger
--  , appStatic :: Static
--  , appConnectionPool :: ConnectionPool

-- Derive routes and instances for App.
-- mkYesod
--   "App"
--   [parseRoutes|
-- / HomeR GET

{- | ]
instance Yesod App -- Methods in here can be overridden as needed.
-}
main :: IO ()
main = warp 3000 AppEnvironment
