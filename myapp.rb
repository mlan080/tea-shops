require 'sinatra'
require 'json'
require_relative 'app/models/shop'

get '/v1/shops' do
  content_type :json
  Shop.all.to_json
end

put '/v1/shops/:id' do
  payload = JSON.parse(request.body.read)
  shop = Shop.find(params[:id])
  shop.name = payload["name"]
  shop.update
  204
end
