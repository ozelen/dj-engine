class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.integer :hotel_id
      t.integer :service_type_id
      t.string :name
      t.text :description
      t.string :price

      t.timestamps
    end
  end
end
