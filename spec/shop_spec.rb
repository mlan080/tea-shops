require 'spec_helper'

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
    let(:shop_id) { Shop.new({name: 'Mandy', description: 'be careful'}).create }

    it 'returns the given shop row from shops table' do
      result = Shop.find(shop_id)

      expect(result.name).to eq('Mandy')
    end

    it 'returns a Shop instance' do
      result = Shop.find(shop_id)

      expect(result.class).to eq(Shop)
    end
  end

  describe "#update" do
    let(:shop_id) { Shop.new({name: 'Mandy', description: 'be careful'}).create }

    it'updates the shop with name Pandy' do
      shop = Shop.find(shop_id)
      shop.name = 'Pandy'
      shop.update
      result = Shop.find(shop_id) #reloads from the db

      expect(result.name).to eq('Pandy')
    end
  end

  describe "#delete" do
    let(:shop_id) { Shop.new({name: 'tommy', description: 'is sour'}).create }

    it 'deletes the database record' do
      shop = Shop.find(shop_id)

      expect{ shop.delete }.to change { Shop.count }.by(-1)
    end
  end

  describe "#valid?" do
    context 'When shop has the required attributes' do
      let(:shop) { Shop.new(name: 'mandy', description: 'is quite radical') }

      it 'is valid' do
        expect(shop.valid?).to be_truthy
      end

      it 'has no error message' do
        shop.valid?

        expect(shop.errors).to be_empty
      end
    end

    context 'When shop does not have the required attributes' do
      let(:shop) { Shop.new }

      it 'is invalid' do
        expect(shop.valid?).to be_falsey
      end

      it 'has error message' do
        shop.valid?

        expect(shop.errors).to eq(["name can't be blank", "description can't be blank"])
      end
    end
  end
end
