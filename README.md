# docker-dev

A framework for doing development in docker

Start a generic Elixir/Erlang docker container

Bind the appropriate volumes

Expose the appropriate parts

Jobs a good un

# How to use (if you are only using for one Elixir development

* Clone this repository
* Clone the elixir repository in a directory under the root of this repository
* in the `docker-compose.yml` file edit the value `target` to point to the directory of your development repo
* start docker
* start the container with `docker-compose up`
* leave running in the shell, switch to a new shell and run `./scripts/start_devenv.sh` this will connect you to a shell inside the development environment

# How to use on a repo that you which to check GitHub documents generated with Jekyll on

* copy the files in `priv/` into your `docs/` directory

# How to use multiple times

If you want to use this for multiple Elixir repos then there will be name clashes which you need to fix:

* you will need to edit the service name in `docker-compose.yml`
* the means the container in `scripts/start_devenv.sh` will have the wrong name
* the mounted directory `target/` in `docker-compose.yml` will need to be edited too, as per a singe use 

