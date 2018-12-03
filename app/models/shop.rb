require 'sequel'

DB = Sequel.connect('sqlite://tea-shops.sqlite')

class Shop
  attr_accessor :name, :description #instance methods
  def create
    shops = DB[:shops] # Define a dataset, table: shops
    shops.insert(:name => name, :description => description) # Populate the table, :name is column name, name is method accessing the instance variable
  end

  def initialize(hash = {})
    @name = hash[:name]
    @description = hash[:description]
  end

  def self.count #class method - used when functionality does not belong to an.instance of that class
    DB[:shops].count
  end

  def self.last
    DB[:shops].order(:id).last #prevents sequel error: no order specified
  end

  def self.all
    DB[:shops].all
  end

  def self.find(id)
    record = DB[:shops].first(id: id) #sequel doc uses first for retrieving record
    Shop.new(record) #returns a shop object with hash argument
  end
end
