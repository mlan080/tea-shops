require 'sinatra'
require 'json'
require_relative 'app/models/shop'

get '/v1/shops' do
  content_type :json
  Shop.all.to_json
end

post '/v1/shops' do
  payload = JSON.parse(request.body.read)
  shop = Shop.new(name: payload["name"], description: payload["description"]).create
  201
end
