class AddTypeIdToServices < ActiveRecord::Migration
  def up
    add_column :services, :type_id, :integer
    add_index :services, :type_id
  end
  def down
    remove_column :services, :type_id
  end
end
