require_relative '../../config/database'

class Shop
  attr_accessor :name, :description #instance methods
  attr_reader :id, :errors

  def create
    shops = DB[:shops]
    shops.insert(:name => name, :description => description) # Populate the table, :name is column name, name is method accessing the instance variable
  end

  def initialize(hash = {})
    @id = hash[:id]
    @name = hash[:name]
    @description = hash[:description]
    @errors = []
  end

  def self.count
    collection.count
  end

  def self.last
    last_record = collection.order(:id).last
    Shop.new(last_record)
  end

  def self.all
    collection.all.map{ |attrs| Shop.new(attrs) }
  end

  def self.find(id)
    record = collection.first(:id => id) #sequel doc uses first for retrieving record
    Shop.new(record) #returns a shop object with hash argument
  end

  def update
    class.collection.where(id: id).update(name: name)
    record = self.class.collection.first(id: id)
    Shop.new(record) #returns a shop object with hash argument
  end

  def delete
    self.class.collection.where(id: id).delete
  end

  def valid?
    add_error("name can't be blank") if name.to_s.empty?
    add_error("description can't be blank") if description.to_s.empty?

   !errors.any?
  end

  def self.collection
    DB[:shops]
  end

  private
    def add_error(message)
      @errors << message #pushing message to an array
    end
end
