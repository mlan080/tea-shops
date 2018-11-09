FROM ruby:2.5.3-slim-stretch

WORKDIR /tea-shops
COPY Gemfile* ./

RUN apk update && apk add --no-cache \
    build-base \
    libcurl \
    libffi-dev \
    nodejs \
    imagemagick \
 && bundle install \
 && apk del --purge build-base

COPY . ./

ENTRYPOINT ["bundle", "exec"]
