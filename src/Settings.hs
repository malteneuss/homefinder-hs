{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# HLINT ignore "Use newtype instead of data" #-}
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

module Settings where

import Control.Exception qualified as Exception
import Data.Aeson (FromJSON, Result (..), fromJSON, parseJSON, withObject, (.!=), (.:), (.:?))
import Data.ByteString (ByteString)
import Data.FileEmbed (embedFile)
import Data.Yaml (Value, decodeEither')
import Yesod.Default.Config2 (applyEnvValue, configSettingsYml)

{- | Runtime settings to configure this application. These settings can be
loaded from various sources: defaults, environment variables, config files,
theoretically even a database.
-}
data AppSettings = AppSettings
    { appStaticDir :: String
    , appDatabaseHost :: String
    , appDatabasePort :: String
    , appDatabaseUser :: String
    , appDatabasePassword :: String
    , appDatabaseName :: String
    }
    deriving stock (Show)

-- TODO - Add a way to load these settings from a config file or environment.

{- | @config/settings.yml@, parsed at compile-time to an Aeson @Value@.
 This value can be overlayed with other settings, e.g. from environment variables.
 And then finally parsed into an @AppSettings@.
-}
compileTimeConfigSettings :: Value
compileTimeConfigSettings =
    either Exception.throw id $
        decodeEither' $(embedFile configSettingsYml)

-- | A version of @AppSettings@ parsed at compile time from @config/settings.yml@.
compileTimeAppSettings :: AppSettings
compileTimeAppSettings =
    case fromJSON $ applyEnvValue False mempty compileTimeConfigSettings of
        -- case fromJSON $ configSettingsYmlValue of
        Error e -> error e
        Success settings -> settings

instance FromJSON AppSettings where
    parseJSON = withObject "AppSettings" $ \o -> do
        appStaticDir <- o .: "static-dir"
        -- appRoappHostot <- o .: "approot"
        appDatabaseHost <- o .: "database-host"
        appDatabasePort <- o .: "database-port"
        appDatabaseUser <- o .: "database-user"
        appDatabasePassword <- o .: "database-password"
        appDatabaseName <- o .: "database-name"
        -- appIpFromHeader <- o .: "ip-from-header"
        -- appDatabasePoolsize <- o .: "database-poolsize"

        -- dev                       <- o .:? "development"      .!= defaultDev

        -- appDetailedRequestLogging <- o .:? "detailed-logging" .!= dev
        -- appShouldLogAll           <- o .:? "should-log-all"   .!= dev
        -- appReloadTemplates        <- o .:? "reload-templates" .!= dev
        -- appMutableStatic          <- o .:? "mutable-static"   .!= dev
        -- appSkipCombining          <- o .:? "skip-combining"   .!= dev

        -- appCopyright              <- o .:  "copyright"
        -- appAnalytics              <- o .:? "analytics"

        -- appUseAuthDummyLogin         <- o .:? "use-auth-dummy-login"      .!= dev

        return AppSettings{..}