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
  #end

 # describe "#update" do
    #v = Shop.find(15)
    it'should return updated name Andy' do
    expect(v.name).to eq(shop.set(15, "pandy"))
    end
  end

  describe "#delete" do
    it 'should delete the database record' do
    shop = Shop.new({name: 'tommy', description: 'is sour'})
    id = shop.create
    shop.delete(id)
      expect(Shop.find(id)).to eq(nil)
    end
  end
end
