# Headbanger

Headbanger is a music recommendation and discovery platform.

## Configuration

Rename and edit the `.env.example` file to `.env`. Use the command below to use the variables in development.

```
$ set -a    # set allexport
$ . ./.env  # source .env
```

## Installation

### Development

```
$ gem install bundler --no-ri --no-rdoc
$ bundle install
$ npm install bower
$ rails bower:install
```

Make sure the following systems are configured and running before starting the server:
 - Neo4j
 - PostgreSQL

### Production

Docker and docker-compose are used to build a stable environment. Use the following command to set up the necessary containers. Don't forget to run any migrations.
 
 ```
 $ docker-compose up
 ```

## Upgrade and first-time setup

### Development

```
$ rake db:migrate        # RDBMS
$ rake db:data:migrate   # Graph
```

### Production

```
$ docker-compose run app rake db:migrate
$ docker-compose run app rake db:data:migrate
$ docker-compose run app rake assets:precompile
```