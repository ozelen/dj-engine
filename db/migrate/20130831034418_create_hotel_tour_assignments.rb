class CreateHotelTourAssignments < ActiveRecord::Migration
  def change
    create_table :hotel_tour_assignments do |t|
      t.belongs_to :hotel
      t.belongs_to :tour

      t.timestamps
    end
    add_index :hotel_tour_assignments, :hotel_id
    add_index :hotel_tour_assignments, :tour_id
  end
end
