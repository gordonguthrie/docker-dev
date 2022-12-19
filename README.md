# docker-dev

A framework for doing development in docker

Start a generic Elixir/Erlang docker container

Bind the appropriate volumes

Expose the appropriate parts

Jobs a good un

# Manual Config

You will be running lots of these so you need to do three things:

* if you intend to use Jekyll you will need to copy the files in `priv/` into your `docs/` directory
* the container in `scripts/start_devenv.sh` will have the wrong name
* the mounted directory `target/` in `docker-compose.yml` will be wrong