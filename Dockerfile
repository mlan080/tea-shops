FROM ruby:2.5.3-slim-stretch

WORKDIR /tea-shops
COPY Gemfile* ./
RUN apt-get update \
&& bundle install

COPY . ./

CMD ["ruby", "helloworld.rb"]
