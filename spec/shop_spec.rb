require 'rspec'
require_relative '../app/models/shop'

describe Shop do
  it 'responds to name' do #description of your spec/test
    shop = Shop.new
    expect(shop).to respond_to(:name)
    #expects shop instance to have an name accessor/method
  end

describe "#create" do
  it 'increments data row by 1' do
    shop = Shop.new
    expect{shop.create}.to change{shop.count}
  end
end

describe "#name_matches" do
  it 'should be true if it matches' do
    shop = Shop.new
    shop.description = "Orange tea cafe"
    expect(shop.name_matches).to eq(true)
  end
end
end
