class AddTypeIdToRooms < ActiveRecord::Migration
  def up
    add_column :rooms, :type_id, :integer
    add_index :rooms, :type_id
  end
  def down
    remove_column :rooms, :type_id
  end
end
