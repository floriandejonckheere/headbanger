# Headbanger

![Continuous Integration](https://github.com/floriandejonckheere/headbanger/workflows/Continuous%20Integration/badge.svg)
![Continuous Deployment](https://github.com/floriandejonckheere/headbanger/workflows/Continuous%20Deployment/badge.svg)

![Release](https://img.shields.io/github/v/release/floriandejonckheere/headbanger?label=Latest%20release)
![Deployment](https://img.shields.io/github/deployments/floriandejonckheere/headbanger/production?label=Deployment)


Headbanger is a music recommendation and discovery platform.

## Set up

Use the `bin/setup` script or run the following steps manually.

Set up the PostgreSQL database:

```
rails db:setup
```

Initialize database seeds:

```
rails database:seed             # Production and development seeds
rails database:seed:production  # Production seeds
rails database:seed:development # Development seeds
```

## Migrating

Run database migrations:

```
rails db:migrate
```

## Development

Use the `bin/update` script to update your development environment dependencies.

Useful resources:

- [Ionicons v4](https://ionicons.com/v4/)
- [GraphQL Ruby](https://graphql-ruby.org/)
- [Devise Token Auth](https://devise-token-auth.gitbook.io/devise-token-auth/)
- [GraphQL Devise](https://github.com/graphql-devise/graphql_devise)

## Debugging

To debug the server component in your IDE, start the `debug` instead of the `app` container, and connect to `localhost:1234`.

## Testing

Seed the test database before running the test suite:

```
rails database:seed:production RAILS_ENV=test
```

Run the test suite:

```
rspec
```

## Data sources

### Metal Archives

By default, an NGINX caching proxy is configured on `http://web:81/`.
The app server uses this as default endpoint for queries.
If you wish to override this, set at least the `MA_ENDPOINT` environment variable.
`MA_USER` and `MA_PASSWORD` can be set if the endpoint is protected with HTTP Basic Authentication.

### MusicBrainz

By default, the app server will use the same database settings as the main PostgreSQL server.
If you wish to override this, set the `MB_HOST`, `MB_USER`, `MB_PASSWORD` and `MB_DATABASE` environment variables.
An SSH forwarding container is also available, if the database resides on another host.
In this case, set the `MB_SSH_HOST` environment variable and connect to the `musicbrainz` container.
SSH authentication is handled by the host's SSH agent running on `SSH_AUTH_SOCK`.


## Troubleshooting

Rebuild the search indices:

```sh
rails pg_search:multisearch:rebuild[Artist]
rails pg_search:multisearch:rebuild[Group]
rails pg_search:multisearch:rebuild[Release]
```

## Secrets

### Repository secrets

Github secrets for continuous integration:

- `APP_EMAIL`

- `MA_ENDPOINT` (optional)
- `MA_ENDPOINT_USER` (optional)
- `MA_ENDPOINT_PASSWORD` (optional)

Github secrets for release:

- `SENTRY_AUTH_TOKEN` (needed for uploading source maps to Sentry)
- `DOCKER_TOKEN` (needed for [Github Container Registry](https://docs.github.com/en/packages/getting-started-with-github-container-registry/migrating-to-github-container-registry-for-docker-images))

### Environment secrets

Github secrets for continuous deployment (process):

- `DOCKER_TOKEN` (needed for [Github Container Registry](https://docs.github.com/en/packages/getting-started-with-github-container-registry/migrating-to-github-container-registry-for-docker-images))

- `SWARM_SSH_HOST` (user@host)
- `SWARM_SSH_KEY` (private key of user, RSA format, convert OpenSSH keys by running `ssh-keygen -p -m PEM -f ~/.ssh/id_rsa`)
- `SWARM_SSH_HOST_KEY` (public key of host)

Github secrets for continuous deployment (application):

- `SECRET_KEY_BASE`

- `APP_EMAIL`
- `APP_HOST`

- `PG_HOST` (optional)
- `PG_USER` (optional)
- `PG_PASSWORD` (optional)
- `PG_DATABASE` (optional)

- `RAILS_APP_SENTRY_DSN`
- `VUE_APP_SENTRY_DSN`
- `VUE_APP_INSTANCE`
- `VUE_APP_CACHE_DOMAIN`

- `SMTP_HOST`
- `SMTP_PORT`
- `SMTP_DOMAIN`
- `SMTP_USERNAME`
- `SMTP_PASSWORD`
- `SMTP_FROM`
- `SMTP_TO` (for deployment notifications)

- `MA_ENDPOINT` (optional)
- `MA_ENDPOINT_USER` (optional)
- `MA_ENDPOINT_PASSWORD` (optional)

- `MB_HOST` (optional)
- `MB_USER` (optional)
- `MB_PASSWORD` (optional)
- `MB_DATABASE` (optional)

- `HB_DATA_EXPIRES_IN` (optional)
- `HB_SYNC_LIMIT` (optional)
- `HB_SYNC_INTERVAL` (optional)
- `HB_RECOMMENDATION_LIMIT` (optional)

## Releasing

Update the changelog and bump the version using the `bin/version` tool.
Execute `bin/version --help` to see all parameters.
Create a tag for the version and push it to Github.
A Docker image will automatically be built and pushed to the registry.

```sh
bin/version version 1.0.0
git add lib/headbanger/version.rb web/package.json
git commit -m "Bump version to v1.0.0"
git tag v1.0.0
git push origin master
git push origin v1.0.0
```

## Deployment

**Initial deployment**

```sh
# SSH into the server
ssh root@myserver.com

# Create a user
useradd -G ssh -G docker -m -s /bin/bash headbanger
su - headbanger

# Create SSH keypair
myserver$ mkdir ~/.ssh/
ssh-keygen -f ~/.ssh/headbanger-deployment-key -b 4096 -C "Headbanger deployment key"
cp ~/.ssh/headbanger-deployment-key.pub ~/.ssh/authorized_keys

# Initialize the database
docker exec -ti `docker ps -q name=postgres_postgres` psql -U postgres -c "CREATE ROLE headbanger WITH ENCRYPTED PASSWORD 'headbanger' LOGIN;"
docker exec -ti `docker ps -q name=postgres_postgres` psql -U postgres -c "CREATE DATABASE headbanger OWNER headbanger;"

# Logout, but don't forget to copy over the private key, and the host public key to your local machine
logout
logout

# Generate TLS client certificates for NGINX
openssl req -nodes -new -x509  -keyout ops/client.key -out ops/client.pem
```

Additionally, set `DEPLOY_SSH_KEY`, `DEPLOY_SSH_HOST` and `DEPLOY_SSH_USER` as Github Actions secrets.

**Subsequent deployments**

Ensure the images have been built and are available in the container registry.
Apply your changes in `ops/docker-compose.yml`.
Update the `production` tag to the correct commit and push it to Github
The file will automatically be deployed, and the containers recreated.

```sh
nano ops/docker-compose.yml
git add ops/docker-compose.yml
git commit -m "Update images to latest version"
git tag -f production
git push origin master && git push -f origin production
```

## License

See [LICENSE.md](LICENSE.md).
