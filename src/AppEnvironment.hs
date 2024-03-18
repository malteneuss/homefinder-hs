{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# OPTIONS_GHC -Wno-missing-deriving-strategies #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Use newtype instead of data" #-}

module AppEnvironment where

import Yesod
import Yesod.Static (Static)

-- AppEnvironment
data AppEnvironment = AppEnvironment
  { appStatic :: Static
  }

mkYesodData "AppEnvironment" $(parseRoutesFile "config/routes.yesodroutes")

instance Yesod AppEnvironment where
  defaultLayout :: Widget -> Handler Html
  defaultLayout = bulmaLayout

bulmaLayout :: Widget -> Handler Html
bulmaLayout widget = defaultLayout $ do
  addStylesheet $ StaticR css_bulma_min_css
  -- OR
  -- addStylesheetRemote "https://cdnjs.cloudflare.com/ajax/libs/bulma/0.9.3/css/bulma.min.css"  -- If you're using a CDN
  widget