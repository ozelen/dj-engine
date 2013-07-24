class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :name
      t.text :description
      t.float :location
      t.integer :city_id
      t.integer :user_id
      t.string :ident

      t.timestamps
    end
    add_index :hotels, :city_id
    add_index :hotels, :user_id
    add_index :hotels, :ident_id, unique: true
  end
end
