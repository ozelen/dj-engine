class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.integer :parent
      t.string :name
      t.string :title
      t.string :header
      t.text :content

      t.timestamps
    end
  end
end
