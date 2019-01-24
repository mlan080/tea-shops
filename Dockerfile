FROM ruby:2.5.3-slim-stretch

WORKDIR /tea-shops
COPY Gemfile* ./

RUN apt-get update && apt-get install -y \
  build-essential \
  libsqlite3-dev
RUN bundle install

COPY . ./

CMD ["ruby", "myapp.rb", "-o", "0.0.0.0"]
