{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# OPTIONS_GHC -Wno-missing-deriving-strategies #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Use newtype instead of data" #-}

module Foundation where

import Data.CaseInsensitive qualified as CI
import Data.Text.Encoding qualified as TE
import StaticFiles
import Text.Hamlet (hamletFile)
import Yesod
import Yesod.Static (Static)

-- AppEnvironment, what state we keep around and allow access to in all handlers.
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
    -- typical html body skeleton to add widget to
    $(whamletFile "templates/layout-page.hamlet")
  -- overall html skeleton to add page content to
  withUrlRenderer $(hamletFile "templates/layout-html.hamlet")

-- These Widgets have to be here because they depend on the App type.
navbar :: Widget
navbar = $(whamletFile "templates/widget-navbar.hamlet")

footer :: Widget
footer = $(whamletFile "templates/widget-footer.hamlet")