# tea-shops

# How to create and run a migration
1. Add gem 'sequel' and gem 'sqlite3'
2. Create a basic sequel migration https://github.com/jeremyevans/sequel/blob/master/doc/migration.rdoc#running-migrations and save it in dir db/migrations/migrations/001_create-shops.rb
3. Run `docker-compose run tea-shops bash`
4. Run `sequel -m db/migrations sqlite://tea-shops.sqlite` to create a migration file named tea-shops.sqlite
5. Update your Dockerfile with the missing dependencies
eg. RUN apt-get update && apt-get install -y \
  build-essential \
  libsqlite3-dev
RUN bundle install
6. Run `docker-compose build` to update the docker iamge
7. Run steps 3 and 4 until no errors occur and a new migration file appears in your application
