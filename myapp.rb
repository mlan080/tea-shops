require 'sinatra'
require 'json'
require_relative 'app/models/shop'

get '/v1/shops' do
  content_type :json
  Shop.all.to_json
end

delete '/v1/shops/:id/delete' do
  shop = Shop.find(params[:id])
  shop.delete
  204
end
