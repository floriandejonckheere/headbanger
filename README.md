# Headbanger

Headbanger is a music recommendation and discovery platform.


## Configuration

Copy `headbanger.env.example` to `headbanger.prod.env` and `headbanger.dev.env`. Edit the two files and use the following commands to use `headbanger.dev.env` outside the Docker container.

```
$ set -a                    # set allexport
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

Docker and docker-compose are used in the deployment process. The environment variables `$SKIP_MIGRATE` can be used to skip database migrations. Don't forget to allow your webserver to serve the static assets.

```
# docker-compose up
# chown -R www-data:www-data /var/lib/docker/volumes/headbanger_assets/_data
```

Don't forget to create a read-only PostgreSQL account for the Musicbrainz database.

```
$ PGPASSWORD=abc psql -h $(docker inspect --format '{{ .Networks.IPAddress }}' headbanger_musicbrainz_1) -U abc -W musicbrainz_db
=# CREATE ROLE musicbrainz WITH ENCRYPTED PASSWORD 'mypassword' LOGIN;
=# GRANT CONNECT ON DATABASE musicbrainz_db TO musicbrainz;
=# GRANT USAGE ON SCHEMA musicbrainz TO musicbrainz;
=# GRANT SELECT ON ALL TABLES IN SCHEMA musicbrainz TO musicbrainz;
=# GRANT SELECT ON ALL SEQUENCES IN SCHEMA musicbrainz TO musicbrainz;
```
