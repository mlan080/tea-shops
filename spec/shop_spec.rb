require 'rspec'
require_relative '../app/models/shop'

describe Shop do
  it 'responds to name' do #description of your spec/test
    shop = Shop.new({name:'cafe', desription: 'pink apples'}) #add name to new to prevent Sequel::NotNullConstraintViolation:
    expect(shop).to respond_to(:name)
    #expects shop instance to have an name accessor/method
  end

  describe "#create" do
    let(:shop) { Shop.new({name:'hello', desription: 'dinosaur'}) }

    it 'increments data row by 1' do
      expect{shop.create}.to change{Shop.count} #counts, creates then counts again
    end

    it 'has the same attributes' do
      shop_id = shop.create
      last_shop = Shop.last

      expect(last_shop.id).to eq(shop_id)
      expect(last_shop.name).to eq(shop.name)
    end
  end

  describe "#last" do
    let!(:first_shop) { Shop.new({name: 'Mando', description: 'is hot stuff'}).create }
    let!(:second_shop) { Shop.new({name: 'Mandaline', description: 'is hotter stuff'}).create }

    it 'returns last row from the shops table' do

      expect(Shop.last.id).to eq(second_shop)
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
