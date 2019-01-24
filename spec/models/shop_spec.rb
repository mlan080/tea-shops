require 'spec_helper'

describe Shop do
  it 'responds to name' do #description of your spec/test
    shop = Shop.new({name:'cafe', desription: 'pink apples'}) #add name to new to prevent Sequel::NotNullConstraintViolation:
    expect(shop).to respond_to(:name)
    #expects shop instance to have an name accessor/method
  end

  describe "#create" do
    let!(:shop) { Shop.new({name:'hello', desription: 'dinosaur'}).create }

    it 'increments data row by 1' do
      expect{shop.create}.to change{Shop.count} #counts, creates then counts again
    end

    it 'has the same attributes' do
      last_shop = Shop.last
      expect(last_shop.id).to eq(shop.id)
      expect(last_shop.name).to eq(shop.name)
      expect(last_shop.description).to eq(shop.description)
    end

    it 'returns a Shop istance' do
      expect(shop).to be_kind_of(Shop)
    end
  end

  describe "#count" do
    let!(:first_shop) { Shop.new({name: 'Dando', description: 'is hot stuff'}).create }
    let!(:second_shop) { Shop.new({name: 'Dandaline', description: 'is hotter stuff'}).create }

    it 'counts number of rows from the shops table' do
      expect(Shop.count).to eq(2)
    end
  end

  describe "#last" do
    let!(:first_shop) { Shop.new({name: 'Mando', description: 'is hot stuff'}).create }
    let!(:second_shop) { Shop.new({name: 'Mandaline', description: 'is hotter stuff'}).create }

    it 'returns last row from the shops table' do
      expect(Shop.last.name).to eq(second_shop.name)
    end
  end

  describe ".all" do
    let!(:first_shop) { Shop.new({name: 'Mando', description: 'is hot stuff'}).create }
    let!(:second_shop) { Shop.new({name: 'Mandaline', description: 'is hotter stuff'}).create }

    it 'returns all rows from the shops table' do
      all_shops = Shop.all.map(&:id) #{|x| x.id}
      expect(all_shops).to eq([first_shop.id, second_shop.id])
    end
  end

  describe ".find" do
    let!(:shop) { Shop.new({name: 'Mandy', description: 'be careful'}).create }

    it 'returns the given shop row from shops table' do
      result = Shop.find(shop.id)

      expect(result.name).to eq('Mandy')
    end

    it 'returns a Shop instance' do
      result = Shop.find(shop.id)

      expect(result.class).to eq(Shop)
    end
  end

  describe "#update" do
    let!(:shop) { Shop.new({name: 'Mandy', description: 'be careful'}).create }

    it'updates the shop with name Pandy' do
      shop.name = 'Pandy'
      shop.update
      result = Shop.find(shop.id) #reloads from the db

      expect(result.name).to eq('Pandy')
    end
  end

  describe "#delete" do
    let!(:shop) { Shop.new({name: 'tommy', description: 'is sour'}).create }

    it 'deletes the database record' do
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

  describe "#.collection" do
    it 'returns collection from the shops table in the database' do
      shop = Shop.collection
      expect(shop).to eq(DB[:shops])
    end
  end
end

