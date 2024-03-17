{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# OPTIONS_GHC -Wno-missing-deriving-strategies #-}

module AppEnvironment where

import Yesod

data AppEnvironment = AppEnvironment
  {
  }

mkYesodData "AppEnvironment" $(parseRoutesFile "src/routes.yesodroutes")

instance Yesod AppEnvironment