require 'sequel'

if ENV['APP_ENV'] == 'test'
    database_name = 'tea-shops_test.sqlite'
else
    database_name  = 'tea-shops_dev.sqlite'
end

DB = Sequel.connect("sqlite://#{database_name}")
