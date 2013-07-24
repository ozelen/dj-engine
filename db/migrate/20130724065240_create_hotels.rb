class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :name
      t.text :description
      t.float :location
      t.integer :city_id
      t.integer :user_id

      t.timestamps
    end
  end
end
