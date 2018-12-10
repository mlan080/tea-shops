If ENV[‘APP_ENV’] == ‘test’
    Database_name = “tea-shops_test.sqlite”
Else
    database_name  = “teashops_dev.sqlite”
End

DB = Sequel.connect("sqlite://#{database_name}")
