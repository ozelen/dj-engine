class CreateMeasures < ActiveRecord::Migration
  def change
    create_table :measures do |t|
      t.integer :measure_category_id
      t.string :iso
      t.string :name

      t.timestamps
    end
  end
end
