{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE UndecidableInstances #-}
{-# OPTIONS_GHC -Wno-orphans #-}

module DB.Model where

import Data.Text (Text)
import Database.Persist.TH (mkMigrate, mkPersist, persistLowerCase, share, sqlSettings)

import Data.Time (UTCTime)
import Data.UUID (UUID)
import Data.UUID qualified as UUID
import Database.Persist.Sql (LiteralType (Escaped), PersistField (..), PersistFieldSql (..), PersistStoreWrite (update), PersistValue (..), SqlType (SqlOther))
import Web.PathPieces (PathPiece (..))

share
    [mkPersist sqlSettings, mkMigrate "migrateAll"]
    [persistLowerCase|
                Home
                    Id   UUID default=uuid_generate_v4()
                    title Text
                    price Int Maybe
                    address Text
                    rooms Int Maybe
                    sqmLivingSpace Int Maybe
                    sqmPropertySpace Int Maybe
                    bedrooms Int Maybe
                    bathrooms Int Maybe
                    details Text
                    originalSource Text
                    sourceUrl Text
                    firstFetchDate UTCTime
                    lastFetchDate UTCTime
                    createdAt UTCTime default=now()
                    updatedAt UTCTime
                    deriving Show
        |]

instance PersistField UUID where
    toPersistValue uuid = PersistLiteralEscaped (UUID.toASCIIBytes uuid)
    fromPersistValue (PersistLiteral_ Escaped bs) = case UUID.fromASCIIBytes bs of
        Just uuid -> Right uuid
        Nothing -> Left "Invalid UUID value"
    fromPersistValue _ = Left "Invalid UUID value"

instance PersistFieldSql UUID where
    sqlType _ = SqlOther "UUID"

instance PathPiece UUID where
    fromPathPiece = UUID.fromText
    toPathPiece = UUID.toText
