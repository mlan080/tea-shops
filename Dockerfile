FROM ruby:2.5.3-slim-stretch

RUN apt-get update

WORKDIR /app
ADD Gemfile* ./

RUN bundle install

ADD helloworld.rb ./
ADD spec/lib/shop_spec.rb ./

CMD ["rspec", "spec/lib/shop_spec.rb"]
