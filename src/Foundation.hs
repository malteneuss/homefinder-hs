{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# OPTIONS_GHC -Wno-missing-deriving-strategies #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Use newtype instead of data" #-}

module Foundation where

import StaticFiles
import Text.Hamlet (hamletFile)
import Text.Julius (juliusFile)
import Yesod
import Yesod.Static (Static)
-- import Yesod.Default.Util (widgetFileNoReload)
-- import Data.Default (def)

-- App(Environment): state we keep around while this app is running, 
-- database connections, loggers etc.
-- All handlers have access to this value.
data App = App
  { appStatic :: Static
  }

mkYesodData "App" $(parseRoutesFile "config/routes.yesodroutes")


instance Yesod App where
  defaultLayout :: Widget -> Handler Html
  defaultLayout = bulmaLayout

bulmaLayout :: Widget -> Handler Html
bulmaLayout widget = do
  -- msgs <- getMessages
  pc <- widgetToPageContent $ do
    -- addStylesheetRemote "https://cdnjs.cloudflare.com/ajax/libs/bulma/0.9.3/css/bulma.min.css"  -- If you're using a CDN
    addStylesheet $ StaticR css_bulma_min_css
    -- typical html body skeleton with navbar and footer to add widget to
    -- $(widgetFileNoReload def "templates/layout-page")
    toWidgetHead $(juliusFile "templates/layout-page.julius")
    $(whamletFile "templates/layout-page.hamlet")
  -- overall html skeleton to add page content to
  withUrlRenderer $(hamletFile "templates/layout-html.hamlet")


-- Helper functions 

-- These Widgets have to be here because they depend on the App type.
navbar :: Widget
navbar = $(whamletFile "templates/widget-navbar.hamlet")

footer :: Widget
footer = $(whamletFile "templates/widget-footer.hamlet")