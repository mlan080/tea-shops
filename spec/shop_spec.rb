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
      expect{shop.create}.to change{Shop.count} #counts creates then counts again
    end

    it 'should have the same attributes' do
      shop = Shop.new "cafe"
      shop.name = "momatcha"
      shop.description = "hot tea"
      expect{shop.create}.to eq(Shop.last) #rspec matcher tests if object passed to expect is = to object passed to eq
    end

      # expect(shop.name_matches).to eq(true)
      # check that the saved Shop, has the same description and name as we provided earlier
  end
end

