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
    DB[:shops].count
  end

  def self.last
    last_record = DB[:shops].order(:id).last
    Shop.new(last_record)
  end

  def self.all
    DB[:shops].all
  end

  def self.find(id)
    record = DB[:shops].first(:id => id) #sequel doc uses first for retrieving record
    Shop.new(record) #returns a shop object with hash argument
  end

  def update
    DB[:shops].where(id: id).update(name: name)
    record = DB[:shops].first(id: id)
    Shop.new(record) #returns a shop object with hash argument
  end

  def delete
    DB[:shops].where(id: id).delete
  end

  def valid?
    add_error("name can't be blank") if name.to_s.empty?
    add_error("description can't be blank") if description.to_s.empty?

   !errors.any?
  end

  private
    def add_error(message)
      @errors << message #pushing message to an array
    end
end
