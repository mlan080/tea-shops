require 'rspec'
require_relative '../app/models/shop'

describe Shop do
  it 'responds to name' do
    shop = Shop.new

    expect(shop).to respond_to(:name)
    #expects shop instance to have an age accessor which it doesn't have
  end

  it 'sums two numbers' do
    result = Shop.sum(3,4)

    expect(result).to eq(7)
  end
end

