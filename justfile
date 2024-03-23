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
    docker-compose -f ./db/docker-compose.yml up
dbdown:
    docker-compose -f ./db/docker-compose.yml down -v
