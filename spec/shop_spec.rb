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
    it 'should have same number of shops as db' do
      shop = Shop.new "cafe"
      expect(Shop.all).to eq(rows)
    end
  end
end
