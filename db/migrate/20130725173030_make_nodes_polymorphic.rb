class MakeNodesPolymorphic < ActiveRecord::Migration
  def up
    add_column :nodes, :accessible_id, :integer
    add_column :nodes, :accessible_type, :string
    add_index :nodes, [:accessible_id, :accessible_type]
  end

  def down
    remove_column :nodes, :accessible_id
    remove_column :nodes, :accessible_type
  end
end
