class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.text :description
      t.float :location
      t.integer :region_id

      t.timestamps
    end
  end
end
