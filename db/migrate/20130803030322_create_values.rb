class CreateValues < ActiveRecord::Migration
  def change
    create_table :values do |t|
      t.string :field_id
      t.string :measure_id

      t.string :value_string
      t.integer :value_integer
      t.float :value_float
      t.datetime :value_datetime
      t.time :value_time

      t.belongs_to :evaluated, polymorphic: true

      t.timestamps
    end
    add_index :values, [:evaluated_id, :evaluated_type]
  end
end
