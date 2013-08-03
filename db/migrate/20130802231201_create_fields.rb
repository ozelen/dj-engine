class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.string :name
      t.belongs_to :measure_category
      t.boolean :required
      t.belongs_to :type

      t.timestamps
    end
    add_index :fields, :measure_category_id
    add_index :fields, :type_id
  end
end
