# Stage 0: build application
FROM node:alpine AS build

MAINTAINER Florian Dejonckheere <florian@floriandejonckheere.be>
LABEL org.opencontainers.image.source https://github.com/floriandejonckheere/headbanger

ENV BUILD_DEPS yarn python g++ make openssl

ENV APP_HOME /app/
WORKDIR $APP_HOME/

# Install system dependencies
RUN apk add --no-cache $BUILD_DEPS

# Install Node dependencies
ADD package.json yarn.lock $APP_HOME/

RUN yarn install

ARG SENTRY_AUTH_TOKEN
ARG SENTRY_ORG=headbanger
ARG SENTRY_PROJECT=web

# Add application
ADD . $APP_HOME/

# Build application
RUN yarn build

# Generate TLS client key and certificate
RUN openssl req -nodes -new -x509 -keyout /etc/nginx/conf.d/client.key -out /etc/nginx/conf.d/client.pem -subj "/C=BE/ST=/L=/O=CN=headbang.re"

# Stage 1: run application
FROM nginx:alpine

MAINTAINER Florian Dejonckheere <florian@floriandejonckheere.be>

# Copy
COPY --from=build /app/docker-entrypoint.sh /docker-entrypoint.sh
COPY --from=build /app/dist/ /usr/share/nginx/html
COPY --from=build /app/nginx/ /etc/nginx/

EXPOSE 81
