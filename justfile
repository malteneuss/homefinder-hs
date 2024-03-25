default:
    @just --list

# Run hoogle
docs:
    echo http://127.0.0.1:8888
    hoogle serve -p 8888 --local

# Run cabal repl
repl *ARGS:
    cabal repl {{ARGS}}

# Autoformat the project tree
fmt:
    treefmt

# Run ghcid -- auto-recompile and run `main` function
run:
    ghcid -c "cabal repl exe:homefinder" --warnings -T :main

# Start and seed local database, and autoremove all state with Ctrl+c
db: && dbup dbmigrateall dbseed
    @echo "Database started and seeded. Press Ctrl+c to stop and remove all state."

dbup: 
    docker-compose -f ./docker-compose.yml up -d
dbdown:
    docker-compose -f ./docker-compose.yml down -v

# print SQL code to do the next migration 
dbprintmigration:
    cabal run exe:migrator
# create new migration script with dbmate new "name"

dbmigrateall:
    dbmate --wait up

dbseed:
    psql -d $DATABASE_URL -f ./db/seed.sql

dbpeek tablename:
    psql -d $DATABASE_URL -c "SELECT * FROM {{tablename}} LIMIT 30;"

# Just create the database, but no tables or data
dbcreate:
    dbmate create
# delete the database with all tables and data
dbdrop:
    dbmate drop

# show what postgres extensions are available
dbshowextensions:
    psql -d $DATABASE_URL -c "SELECT * FROM pg_available_extensions;"
 