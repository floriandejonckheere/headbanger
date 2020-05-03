# Headbanger

Headbanger is a music recommendation and discovery platform.

## Set up

Migrate the PostgreSQL database:

```
rails db:migrate
```

Migrate the Neo4j database:

```
rails neo4j:migrate
```

Initialize database seeds (for both PostgreSQL and Neo4j):

```
rails database:seed             # Production and development seeds
rails database:seed:production  # Production seeds
rails database:seed:development # Development seeds
```

Generate TLS client certificates for NGINX:

```
openssl req  -nodes -new -x509  -keyout web/nginx/client.key -out web/nginx/client.pem
```

## Testing

Seed the test database before running the test suite:

```
rails database:seed:production RAILS_ENV=test
```

Run the test suite:

```
rspec
```

## Releasing

Update the changelog and bump the version in `lib/headbanger/version.rb` and `web/package.json`.
Create a tag for the version and push it to Github.
A Docker image will automatically be built and pushed to the registry.

```
git add lib/headbanger/version.rb web/package.json
git commit -m "Bump version to v1.0.0"
git tag v1.0.0
git push origin master
git push origin v1.0.0
```
