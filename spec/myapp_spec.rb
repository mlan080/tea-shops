require 'spec_helper'
require_relative '../app/models/shop'

describe 'myapp' do
  include Rack::Test::Methods

  def app
    Sinatra::Application.new
  end

  describe 'root path' do
    let!(:shop) { Shop.new({name: 'mandy', description: 'bla'}).create }

    before do
      get '/v1/shops'
    end

    it 'returns successful json response' do
      expect(last_response).to be_ok
    end

    it 'returns response in json format' do
      expect(last_response.content_type).to eq('application/json')
    end

    it 'returns shops in json' do
      response_data = JSON.parse(last_response.body)
      expect(response_data).to eq([{"description"=>"bla", "id"=> shop.id, "name"=>"mandy"}])
    end
  end

  describe "GET v1/shops/:id" do
    let!(:shop) { Shop.new({name: "RedPanda", description: "It is fluffy"}).create }

    let(:response) { get "/v1/shops/#{shop.id}" }

    it 'returns status 200 OK' do
      expect(Shop.last).not_to eq(nil)
      expect(response.status).to eq 200
    end

    it 'displays the shops name and description' do
     response_data = JSON.parse(response.body)
     expect(response_data).to eq("id" => shop.id, "name" => "RedPanda", "description" => "It is fluffy")
    end
  end
end
