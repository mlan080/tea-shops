require 'sinatra'
require 'json'
require_relative 'app/models/shop'

get '/v1/shops' do
  content_type :json
  Shop.all.to_json
end

put '/v1/shops/:id' do
  shop = Shop.find(params[:id])
  shop.name = ""
  shop.update
  "204 content not found"
end
