require 'sequel'

DB = Sequel.connect('sqlite://tea-shops.sqlite')

class Shop
  attr_accessor :name, :description #instance methods
  def create
    shops = DB[:shops] # Define a dataset, table: shops
    shops.insert(:name => name, :description => description) # Populate the table, :name is column name, name is method accessing the instance variable
  end

  def initialize(name)
   @name = name
  end

  def self.count #class method - used when functionality does not belong to an.instance of that class
    DB[:shops].count
  end

  def self.last
    DB[:shops].last
  end
end
