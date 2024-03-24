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
db:
    docker-compose -f ./docker-compose.yml up
dbdown:
    docker-compose -f ./docker-compose.yml down -v

dbmigrate:
    dbmate up

dbseed:
    psql -d $DATABASE_URL -f ./db/seed.sql

dbpeek tablename:
    psql -d $DATABASE_URL -c "SELECT * FROM {{tablename}} LIMIT 10;"

dbdrop:
    dbmate drop
 