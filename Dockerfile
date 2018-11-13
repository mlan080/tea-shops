FROM ruby:2.5.3-slim-stretch

WORKDIR /tea-shops
COPY Gemfile* ./

RUN apt-get update

CMD ["ruby", "exec"]
