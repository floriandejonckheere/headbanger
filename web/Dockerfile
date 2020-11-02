# Stage 0: build application
FROM node:alpine AS build

MAINTAINER Florian Dejonckheere <florian@floriandejonckheere.be>

ENV BUILD_DEPS yarn python g++ make

ENV APP_HOME /app/
WORKDIR $APP_HOME/

# Install system dependencies
RUN apk add --no-cache $BUILD_DEPS

# Install Node dependencies
ADD package.json yarn.lock $APP_HOME/

RUN yarn install

ARG SENTRY_AUTH_TOKEN
ARG SENTRY_ORG
ARG SENTRY_PROJECT

# Add application
ADD . $APP_HOME/

# Build application
RUN yarn build

# Stage 1: run application
FROM nginx:alpine

MAINTAINER Florian Dejonckheere <florian@floriandejonckheere.be>

# Copy
COPY --from=build /app/dist/ /usr/share/nginx/html
COPY --from=build /app/nginx/ /etc/nginx/

EXPOSE 81
