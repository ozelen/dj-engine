class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.integer :parent_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
