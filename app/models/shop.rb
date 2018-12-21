require_relative '../../config/database'

class Shop
  attr_accessor :id, :name, :description #instance methods
  attr_reader :errors

  def create
    id = DB[:shops].insert(name: self.name, description: self.description) #self refers to the object calling the create method
    Shop.find(id) #return the shop object
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
    puts last_record.inspect
    Shop.new(last_record)
  end

  def self.all
    collection.all.map{ |attrs| Shop.new(attrs) }
  end

  def self.find(id)
    record = collection.first(id: id) #sequel doc uses first for retrieving record
    Shop.new(record) #returns a shop object with hash argument
  end

  def update
    self.class.collection.where(id: id).update(name: name)
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

  def to_json(options={})
    {
      id: @id,
      name: @name,
      description: @description
    }.to_json
  end

  private
    def add_error(message)
      @errors << message #pushing message to an array
    end
end
