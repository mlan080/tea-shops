FROM ruby:2.5.3-slim-stretch

WORKDIR /app

RUN apt-get update

CMD ["ruby"]
