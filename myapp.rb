require 'sinatra'
require 'json'
require_relative 'app/models/shop'

get '/v1/shops' do
  content_type :json
  Shop.all.to_json
end

post '/v1/shops' do
  shop = Shop.new(name: "", description: "").create
  "201 created"
end
