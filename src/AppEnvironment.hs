{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# OPTIONS_GHC -Wno-missing-deriving-strategies #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Use newtype instead of data" #-}

module AppEnvironment where

import StaticFiles
import Yesod
import Yesod.Static (Static)

-- AppEnvironment
data AppEnvironment = AppEnvironment
  { appEnvironmentStatic :: Static
  }

mkYesodData "AppEnvironment" $(parseRoutesFile "config/routes.yesodroutes")

instance Yesod AppEnvironment where
  defaultLayout :: Widget -> Handler Html
  defaultLayout = bulmaLayout

-- Copy of default layout but with bulma css.
bulmaLayout :: Widget -> Handler Html
bulmaLayout w = do
  p <- widgetToPageContent $ do
    -- addStylesheetRemote "https://cdnjs.cloudflare.com/ajax/libs/bulma/0.9.3/css/bulma.min.css"  -- If you're using a CDN
    addStylesheet $ StaticR css_bulma_min_css
    toWidgetHead
      [hamlet|
          <meta charset="utf-8">
          <meta name="viewport" content="width=device-width, initial-scale=1">        
        |]
    w
  msgs <- getMessages
  withUrlRenderer
    [hamlet|
$newline never
$doctype 5
<html>
    <head>
        <title>#{pageTitle p}
        
        $maybe description <- pageDescription p
          <meta name="description" content="#{description}">
        ^{pageHead p}
    <body>
        $forall (status, msg) <- msgs
            <p class="message #{status}">#{msg}
        ^{pageBody p}
          |]