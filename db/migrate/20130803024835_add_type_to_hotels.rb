class AddTypeToHotels < ActiveRecord::Migration
  def up
    add_column :hotels, :type_id, :integer
    add_index :hotels, :type_id
  end
  def down
    remove_column :hotels, :type_id
  end
end
