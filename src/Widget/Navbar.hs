{-# LANGUAGE TemplateHaskell #-}

module Widget.Navbar where

import Foundation
import Yesod

navbar :: Widget
navbar = $(whamletFile "templates/widget-navbar.hamlet")