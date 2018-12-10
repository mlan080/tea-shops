require 'database_cleaner'
require 'sequel'

DatabaseCleaner[:sequel, {:connection => Sequel.connect('sqlite://tea-shops_test.sqlite')}]
DatabaseCleaner[:sequel].strategy = :truncation
#DatabaseCleaner.clean
