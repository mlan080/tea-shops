Sequel.migration do
  up do #adds a shop table
    create_table(:shops) do
      primary_key :id
      String :name, null: false
    end
  end

  down do
    drop_table(:shops)
  end
end

