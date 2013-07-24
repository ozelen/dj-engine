class CreateMeasureCategories < ActiveRecord::Migration
  def change
    create_table :measure_categories do |t|
      t.string :name
      t.integer :data_type
      t.string :filter

      t.timestamps
    end
  end
end
