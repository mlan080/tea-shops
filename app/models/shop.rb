require 'sequel'

DB = Sequel.connect('sqlite://tea-shops.sqlite')

class Shop
  attr_accessor :name, :description
  def create
    shops = DB[:shops]  
    shops.insert(:name => name, :description => description) # Populate the table, :name is column name, name is method accessing the instance variable
  end

  def initialize(hash = {})
    @name = hash[:name]
    @description = hash[:description]
  end

  def self.count
    DB[:shops].count
  end

  def self.last
    DB[:shops].order(:id).last
  end

  def self.all
    DB[:shops].all
  end

  def self.find(id)
    h = DB[:shops].first(:id => id) #sequel doc uses first for retrieving record
    Shop.new(h) #returns a shop object with hash argument
  end

  def set(id, name)
    DB[:shops].where(id: id).update(name: name)
    record = DB[:shops].first(id: id) 
    Shop.new(record) #returns a shop object with hash argument
  end
end
