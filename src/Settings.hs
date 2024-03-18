{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use newtype instead of data" #-}
module Settings where

{- | Runtime settings to configure this application. These settings can be
loaded from various sources: defaults, environment variables, config files,
theoretically even a database.
-}
data AppSettings = AppSettings
    { appStaticDir :: String
    }

-- TODO - Add a way to load these settings from a config file or environment.

-- | A version of @AppSettings@ parsed at compile time from @config/settings.yml@.
compileTimeAppSettings :: AppSettings
compileTimeAppSettings =
    AppSettings
        { appStaticDir = "static"
        }