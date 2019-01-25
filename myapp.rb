require 'sinatra'
require 'json'
require_relative 'app/models/shop'

before do
 content_type :json
end

get '/v1/shops' do
  Shop.all.to_json
end

get '/v1/shops/:id' do
  shop = Shop.find(params[:id])
  shop.to_json
end

