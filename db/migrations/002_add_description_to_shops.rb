Sequel.migration do
  up do
      add_column :shops, :description, String
    end

  down do
      drop_column :shops, :description
  end
end
