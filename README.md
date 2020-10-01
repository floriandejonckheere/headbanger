# Headbanger

![Continuous Integration](https://github.com/floriandejonckheere/headbanger/workflows/Continuous%20Integration/badge.svg)
![Continuous Deployment](https://github.com/floriandejonckheere/headbanger/workflows/Continuous%20Deployment/badge.svg)

![Release](https://img.shields.io/github/v/release/floriandejonckheere/headbanger?label=Latest%20release)
![Deployment](https://img.shields.io/github/deployments/floriandejonckheere/headbanger/production?label=Deployment)


Headbanger is a music recommendation and discovery platform.

## Set up

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

Generate TLS client certificates for NGINX:

```
openssl req  -nodes -new -x509  -keyout web/nginx/client.key -out web/nginx/client.pem
```

## Migrating

Run database migrations:

```
rails db:migrate
```

## Development

Useful resources:

- [Ionicons v4](https://ionicons.com/v4/)
- [Devise Token Auth](https://devise-token-auth.gitbook.io/devise-token-auth/)
- [GraphQL Devise](https://github.com/graphql-devise/graphql_devise)

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

Github secrets for continuous integration:

- `APP_CONTACT`
- `SENTRY_AUTH_TOKEN`
- `SENTRY_ORG`
- `SENTRY_PROJECT`
- `MA_ENDPOINT` (optional)
- `MA_ENDPOINT_USER` (optional)
- `MA_ENDPOINT_PASSWORD` (optional)

Github secrets for continuous deployment:

- `DEPLOY_SSH_HOST`
- `DEPLOY_SSH_USER`
- `DEPLOY_SSH_KEY`

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

For initial deployment, copy `.env.production`, `client.key` and `client.pem` manually, and initialize the database.

## License

See [LICENSE.md](LICENSE.md).
