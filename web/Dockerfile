FROM node:alpine

MAINTAINER Florian Dejonckheere <florian@floriandejonckheere.be>

ENV BUILD_DEPS build-base curl-dev git

ENV APP_HOME /srv
WORKDIR $APP_HOME

# Install system dependencies
RUN apk add --no-cache $BUILD_DEPS $RUNTIME_DEPS

# Install NPM dependencies
ADD package.json $APP_HOME
RUN yarn

# Add application
ADD . $APP_HOME

CMD ["yarn", "start"]
