require "sequel"

DB = Sequel.sqlite # connects to sqlite3 using sequel

# create an items table
DB.create_table :shops do
  primary_key :id
  String :name
end

shops = DB[:shops] #Create a dataset

#populate the table
shops.insert(:name => 'greentea')
shops.insert(:name => 'red-cafe')

puts "Shops count: #{shops.count}"
