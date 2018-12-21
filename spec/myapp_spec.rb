require 'spec_helper'
require_relative '../app/models/shop'

describe 'myapp' do
  include Rack::Test::Methods

  def app
    Sinatra::Application.new
  end

  describe 'root path' do
    before do
      @shop = Shop.new({name: 'mandy', description: 'bla'})
      @shop.id = @shop.create
      get '/v1/shops'
    end

    after do
      @shop.delete
    end

    it 'should be successfull' do
      expect(last_response).to be_ok
    end

    it 'should be a json response' do
      expect(last_response.content_type).to eq('application/json')
    end

    it 'returns  shops in json' do
      response_data = JSON.parse(last_response.body)
      expect(response_data).to eq([{"description"=>"bla", "id"=>7, "name"=>"mandy"}])
    end
  end
end
