class AddAncestryToTypes < ActiveRecord::Migration
  def change
    add_column :types, :ancestry, :string
    add_index :types, :ancestry
  end
end
