require 'simplecov'
SimpleCov.start

ENV['APP_ENV'] ||= 'test'

require 'rspec'
require 'database_cleaner'
require 'sequel'
require 'rack/test'

require_relative '../myapp.rb'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
