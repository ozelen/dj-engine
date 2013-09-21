class RemoveDataColumnsFromAccessible < ActiveRecord::Migration
  def up
    remove_column :hotels, :name
    remove_column :hotels, :description

    remove_column :cities, :name
    remove_column :cities, :description

    remove_column :regions, :name
    remove_column :regions, :description
  end

  def down
  end
end
