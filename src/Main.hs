{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# OPTIONS_GHC -Wno-missing-deriving-strategies #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module Main where

import Foundation
import Handler.Home (getHomeR)
import Settings (AppSettings (AppSettings, appStaticDir), compileTimeAppSettings, compileTimeConfigSettings)
import Yesod (mkYesodDispatch, parseRoutesFile, warp)
import Yesod.Default.Config2 (loadYamlSettingsArgs, useEnv)
import Yesod.Static (static)

mkYesodDispatch "App" $(parseRoutesFile "config/routes.yesodroutes")

main :: IO ()
main = do
  appSettings <-
    loadYamlSettingsArgs
      -- fall back to compile-time values, set to [] to require values at runtime
      [compileTimeConfigSettings]
      -- allow environment variables to override
      useEnv
  app <- mkFoundation appSettings
  warp 3000 app

mkFoundation :: AppSettings -> IO App
mkFoundation appSettings = do
  appStaticDir <- static $ appStaticDir compileTimeAppSettings
  print appSettings
  return $ App{appStatic = appStaticDir}
