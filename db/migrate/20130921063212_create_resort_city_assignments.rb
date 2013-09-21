class CreateResortCityAssignments < ActiveRecord::Migration
  def change
    create_table :resort_city_assignments do |t|
      t.belongs_to :resort
      t.belongs_to :city

      t.timestamps
    end
    add_index :resort_city_assignments, :resort_id
    add_index :resort_city_assignments, :city_id
  end
end
