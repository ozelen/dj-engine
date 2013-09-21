class AddIndexToNodes < ActiveRecord::Migration
  def change
    add_index :nodes, :header
  end
end
