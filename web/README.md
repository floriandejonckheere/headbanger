# Headbanger UI

Headbanger is a music recommendation and discovery platform.

## Installation

Install NPM packages:

```
yarn install
```

## Development

Run the Vue development server:

```
yarn serve
```

## Production

For Sentry to automatically upload source maps during build, ensure you have a valid auth token in `~/.sentryclirc` or authenticate first:

```
sentry-cli login
```

Build the project:

```
yarn build
```

## Testing

Run the test suite:

```
yarn test:unit
```

### Lints and fixes files
```
yarn lint
```
