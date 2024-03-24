{-# LANGUAGE TypeFamilies #-}
{-# OPTIONS_GHC -Wno-missing-deriving-strategies #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

{-# HLINT ignore "Use toText" #-}

module Main where

import Control.Monad.Logger (runStdoutLoggingT)
import DB.Model (migrateAll)
import Database.Persist.Postgresql (printMigration, runSqlConn, withPostgresqlConn)
import Settings (compileTimeConfigSettings, mkConnectionString)
import Yesod.Default.Config2 (loadYamlSettingsArgs, useEnv)

main :: IO ()
main = do
  appSettings <-
    loadYamlSettingsArgs
      -- fall back to compile-time values, set to [] to require values at runtime
      [compileTimeConfigSettings]
      -- allow environment variables to override
      useEnv
  let connectionString = mkConnectionString appSettings
  print "Printing migrations script. If nothing appears, maybe no change is needed:"
  runStdoutLoggingT $ withPostgresqlConn connectionString $ runSqlConn $ printMigration migrateAll