require 'spec_helper'
require_relative '../app/models/shop'

describe 'myapp' do
  include Rack::Test::Methods

  def app
    Sinatra::Application.new
  end

  describe 'root path' do
      let(:shop) {Shop.new({name: 'mandy', description: 'bla'}) }
      let(:shop) { Shop.create }
      get '/v1/shops'


    it 'returns successful json response' do
      expect(last_response).to be_ok
    end

    it 'returns response in json format' do
      expect(last_response.content_type).to eq('application/json')
    end

    it 'returns shops in json' do
      response_data = JSON.parse(last_response.body)
      expect(response_data).to eq([{"description"=>"bla", "id"=> @shop.id, "name"=>"mandy"}])
    end
  end
end
