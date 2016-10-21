# Headbanger

Headbanger is a music recommendation and discovery platform.

## Configuration

Copy `.env.example` to `production.env` and `development.env`. Edit the two files and symlink `.env` to `production.env`. Use the following commands to use `development.env` outside the Docker container.

```
$ set -a                # set allexport
$ . ./development.env   # source .env
```

## Installation

### Prerequisites

- RVM
- NPM

### Development

```
$ rvm install $(cat .ruby-version)
$ rvm gemset create $(cat .ruby-gemset)
$ rvm use $(cat .ruby-version)@$(cat .ruby-gemset)
$ gem install bundler
$ bundle install
$ npm install bower
$ rails bower:install
```

Make sure the following systems are configured and running before starting the server:
 - Neo4j
 - PostgreSQL
 
For first-time setup, run the following commands
 
```
$ rails db:migrate          # RDBMS
$ rails db:data:migrate     # Graph
```

### Production

Docker and docker-compose are used in the deployment process. Use the following command to build and run the necessary containers. The environment variables `$SKIP_MIGRATE` and `$SKIP_PRECOMPILE` can be used to skip migrations and asset precompilation respectively.
 
```
$ docker-compose up
```

PostgreSQL, Neo4J and Redis data are persisted to disk using Docker volumes.