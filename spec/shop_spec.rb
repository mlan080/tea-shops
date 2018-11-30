require 'rspec'
require_relative '../app/models/shop'

describe Shop do
  it 'responds to name' do #description of your spec/test
    shop = Shop.new "cafe" #add name to new to prevent Sequel::NotNullConstraintViolation:
    expect(shop).to respond_to(:name)
    #expects shop instance to have an name accessor/method
  end

  describe "#create" do
    it 'increments data row by 1' do
      shop = Shop.new "cafe"
      expect{shop.create}.to change{Shop.count} #counts, creates then counts again
    end

    it 'should have the same attributes' do
      shop = Shop.new "cafe"
      shop.description = "hot tea"
      shop.create
      expect(shop.name).to eq(Shop.last[:name]) #[] access column name in db
      expect(shop.description).to eq(Shop.last[:description])
      #rspec matcher tests if object passed to expect is = to object passed to eq
    end
  end

  describe "#all" do
    rows = DB[:shops].all
    it 'should return all rows from the shops table' do
      shop = Shop.new
      expect(Shop.all).to eq(rows)
    end
  end

  describe "#find" do
    shop = Shop.new({name: 'RED', description: 'red apples'})
    v = Shop.find(15)
    it 'should return row with id 15 from the shops table' do
    expect(v.name).to eq(shop.name)
    end
  end

  describe "#update" do
    id = Shop.new({name: 'Mandy', description: 'be careful'}).create
    shop = Shop.find(id)
    shop.set(id, 'Pandy') #updates record in db but not shop variable so pass updated record in next line
    shop = Shop.find(id)
    it'should return updated name pandy in the database' do
    expect(shop.name).to eq('Pandy')

    it'should return updated name Andy' do
    expect(v.name).to eq(shop.set(15, "pandy"))
    end
  end
end
