class CreateResortTourAssignments < ActiveRecord::Migration
  def change
    create_table :resort_tour_assignments do |t|
      t.belongs_to :resort
      t.belongs_to :tour

      t.timestamps
    end
    add_index :resort_tour_assignments, :resort_id
    add_index :resort_tour_assignments, :tour_id
  end
end
