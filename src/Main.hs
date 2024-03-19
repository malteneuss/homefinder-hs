{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# OPTIONS_GHC -Wno-missing-deriving-strategies #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module Main where

import Foundation
import Handler.Home
import Settings (AppSettings (appStaticDir), compileTimeAppSettings)
import Yesod
import Yesod.Static (static)

mkYesodDispatch "App" $(parseRoutesFile "config/routes.yesodroutes")

main :: IO ()
main = do
  appStaticDir <- static $ appStaticDir compileTimeAppSettings
  warp 3000 (App appStaticDir)
