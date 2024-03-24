-- migrate:up
-- we need to create the extension to generate uuids
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE home(
    "id" UUID PRIMARY KEY UNIQUE DEFAULT uuid_generate_v4(),
    "title" VARCHAR NOT NULL,
    "price" INT8 NULL,
    "address" VARCHAR NOT NULL,
    "rooms" INT8 NULL,
    "sqm_living_space" INT8 NULL,
    "sqm_property_space" INT8 NULL,
    "bedrooms" INT8 NULL,
    "bathrooms" INT8 NULL,
    "details" VARCHAR NOT NULL,
    "original_source" VARCHAR NOT NULL,
    "source_url" VARCHAR NOT NULL,
    "first_fetch_date" TIMESTAMP WITH TIME ZONE NOT NULL,
    "last_fetch_date" TIMESTAMP WITH TIME ZONE NOT NULL,
    "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
    "updated_at" TIMESTAMP WITH TIME ZONE NOT NULL
);

-- migrate:down
DROP TABLE home;