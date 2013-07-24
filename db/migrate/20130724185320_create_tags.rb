class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :tag_name_id
      t.integer :value_int
      t.integer :measure_id
      t.float :value_flt
      t.string :value_str
      t.integer :tag_option_id

      t.timestamps
    end
  end
end
