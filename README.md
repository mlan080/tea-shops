# tea-shops

# Setting up the environment for migrations
1. Add gem 'sequel' and gem 'sqlite3'
2. Update your Dockerfile with the missing dependencies
eg. RUN apt-get update && apt-get install -y \
  build-essential \
  libsqlite3-dev
RUN bundle install
3. Run `docker-compose build` to update the docker iamge


# Run a migration
1. Create a basic sequel migration https://github.com/jeremyevans/sequel/blob/master/doc/migration.rdoc#running-migrations and save it in directory db/migrations
2. Run `docker-compose run tea-shops bash`
3. Run `sequel -m db/migrations sqlite://tea-shops.sqlite` to run the migrations on the tea-shops database
