# Stage 0: build application
FROM node:alpine AS build

MAINTAINER Florian Dejonckheere <florian@floriandejonckheere.be>

ENV APP_HOME /app/
WORKDIR $APP_HOME/

# Install Node dependencies
ADD package.json yarn.lock $APP_HOME/

RUN yarn install

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
