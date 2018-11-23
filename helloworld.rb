require_relative 'app/models/shop'
shop = Shop.new
shop.name = "Green Tea Cafe"
shop.description = "Everything is green here especially the poison ivy"
shop.create

shop = Shop.new
shop.name = "RED"
shop.description = "red apples"
shop.create
