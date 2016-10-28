# Headbanger

Headbanger is a music recommendation and discovery platform.

## Configuration

Copy `musicbrainz.env.example` to `musicbrainz.prod.env` and `musicbrainz.dev.env`. Edit the two files and use the following commands to use `musicbrainz.dev.env` outside the Docker container.

Copy `headbanger.env.example` to `headbanger.prod.env` and `headbanger.dev.env`. Edit the two files and use the following commands to use `headbanger.dev.env` outside the Docker container.

```
$ set -a                    # set allexport
$ . ./musicbrainz.dev.env    # source .env
$ . ./headbanger.dev.env    # source .env
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
$ docker-compose -f docker-compose.yml -f docker-compose.prod.yml up
```

Data volumes (PostgreSQL, Neo4j, Redis, Musicbrainz) are persisted to disk using Docker volumes. Don't forget to create a read-only PostgreSQL account for the Musicbrainz database.

```
$ PGPASSWORD=abc psql -h $(docker inspect --format '{{ .Networks.IPAddress }}' headbanger_musicbrainz_1) -U abc -W musicbrainz_db
=# CREATE ROLE musicbrainz WITH ENCRYPTED PASSWORD 'mypassword' LOGIN;
=# GRANT CONNECT ON DATABASE musicbrainz_db TO musicbrainz;
=# GRANT USAGE ON SCHEMA musicbrainz TO musicbrainz;
=# GRANT SELECT ON ALL TABLES IN SCHEMA musicbrainz TO musicbrainz;
```

#### Redeployment

```
$ docker-compose up --no-deps -d app
```
