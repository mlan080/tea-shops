require 'sequel'

DB = Sequel.connect('sqlite://tea-shops.sqlite')

class Shop
  attr_accessor :name, :description #instance methods
  def create
    shops = DB[:shops] # Define a dataset, table: shops
    shops.insert(:name => name, :description => description) # Populate the table, :name is column name, name is method accessing the instance variable
  end

  def initialize
    @name = "Orange tea cafe"
  end

  def count
    return DB[:shops].count
  end

  def name_matches
    name == description
  end
end
