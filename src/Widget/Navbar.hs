{-# LANGUAGE TemplateHaskell #-}

module Widget.Navbar where

import AppEnvironment
import Yesod

navbar :: Widget
navbar = $(whamletFile "templates/widget-navbar.xhamlet")