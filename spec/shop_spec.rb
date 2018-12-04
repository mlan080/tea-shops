require 'rspec'
require_relative '../app/models/shop'

describe Shop do
  it 'responds to name' do #description of your spec/test
    shop = Shop.new({name:'cafe', desription: 'pink apples'}) #add name to new to prevent Sequel::NotNullConstraintViolation:
    expect(shop).to respond_to(:name)
    #expects shop instance to have an name accessor/method
  end

  describe "#create" do
    it 'increments data row by 1' do
      shop = Shop.new({name:'cafe', desription: 'pink apples'})
      expect{shop.create}.to change{Shop.count} #counts, creates then counts again
    end

    it 'should have the same attributes' do
      shop = Shop.new({name:'cafe', desription: 'pink apples'})
      shop.create
      expect(shop.name).to eq(Shop.last[:name]) #[] access column name in db
      expect(shop.description).to eq(Shop.last[:description])
      #rspec matcher tests if object passed to expect is = to object passed to eq
    end
  end

  describe ".all" do
    let(:rows) { DB[:shops].all }

    it 'returns all rows from the shops table' do

      expect(Shop.all).to eq(rows)
    end
  end

  describe ".find" do
    before { Shop.new({name: 'cafe', description: 'red apples'}).create }

    let(:last_shop) { Shop.all.last } #defining variable to use in spec

    it 'returns the given shop row from shops table' do
      result = Shop.find(last_shop[:id])

       expect(result.name).to eq('cafe')
    end

    it 'returns the instance class' do
      result = Shop.find(last_shop[:id])

      expect(result.class).to eq(Shop)
    end

  describe "#update" do
    let(:shop_id) { Shop.new({name: 'Mandy', description: 'be careful'}).create }

    it'should return updated name Pandy in the database' do
      shop = Shop.find(shop_id)
      shop.name = 'Pandy'
      shop.update
      shop_result = Shop.find(shop_id) #reloads from the db

      expect(shop_result.name).to eq('Pandy')
    end
  end
end
