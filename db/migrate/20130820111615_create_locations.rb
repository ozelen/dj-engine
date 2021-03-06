class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.belongs_to :located, polymorphic: true

      t.timestamps
    end
    add_index :locations, [:located_id, :located_type]
  end
end
