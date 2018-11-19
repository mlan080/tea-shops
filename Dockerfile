FROM ruby:2.5.3-slim-stretch

WORKDIR /tea-shops

RUN apt-get update

COPY . ./

CMD ["ruby", "helloworld.rb"]
