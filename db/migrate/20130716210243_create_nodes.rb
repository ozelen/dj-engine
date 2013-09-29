class CreateNodes < ActiveRecord::Migration
  def self.up
    create_table :nodes do |t|
      t.string :parent
      t.string :name
      t.string :title
      t.string :header
      t.text :content

      t.timestamps
    end

    add_index :nodes, :parent
    add_index :nodes, :name
    add_index :nodes, :header

  end
end
