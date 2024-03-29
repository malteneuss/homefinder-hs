{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# OPTIONS_GHC -Wno-missing-deriving-strategies #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

{-# HLINT ignore "Use toText" #-}

module Main where

import Control.Monad.Logger (runLoggingT, runStdoutLoggingT)
import DB.Model (migrateAll)
import Database.Persist.Postgresql (createPostgresqlPool, printMigration, runSqlPool)
import Foundation (App (..), Route (HomeR, StaticR))
import Handler.Home (getHomeR)
import Settings (AppSettings (..), compileTimeAppSettings, compileTimeConfigSettings, mkConnectionString)
import System.Log.FastLogger (
  defaultBufSize,
  newStdoutLoggerSet,
 )
import Yesod (messageLoggerSource, mkYesodDispatch, parseRoutesFile, warp)
import Yesod.Default.Config2 (loadYamlSettingsArgs, makeYesodLogger, useEnv)
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
  appStatic <- static $ appStaticDir compileTimeAppSettings
  appLogger <- newStdoutLoggerSet defaultBufSize >>= makeYesodLogger
  -- We need a log function to create a connection pool. We need a connection
  -- pool to create our foundation. And we need our foundation to get a
  -- logging function. To get out of this loop, we initially create a
  -- temporary foundation without a real connection pool, get a log function
  -- from there, and then create the real foundation.
  -- let fakeFoundation :: App
  --     fakeFoundation = error "FakeFoundation forced in tempFoundation"
  let mkFakeFoundation fakeDbConnPool =
        App
          { appStatic
          , appDbConnPool = fakeDbConnPool
          , -- , appHttpManager
            appLogger
          }
  let fakeFoundation = mkFakeFoundation $ error "connPool forced in tempFoundation"
  -- messageLoggerSource needs our Foundation App value to use
  -- the shouldLogIO function from its Yesod instance.
  -- logFunc :: Loc -> LogSource -> LogLevel -> LogStr -> IO ()
  let logFunc = messageLoggerSource fakeFoundation appLogger
  appDbConnPool <-
    flip runLoggingT logFunc $
      createPostgresqlPool (mkConnectionString appSettings) (appDatabasePoolsize appSettings)
  runStdoutLoggingT $ flip runSqlPool appDbConnPool $ printMigration migrateAll
  return $ App{appStatic, appDbConnPool, appLogger}
