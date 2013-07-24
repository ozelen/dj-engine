class CreateTagNames < ActiveRecord::Migration
  def change
    create_table :tag_names do |t|
      t.integer :tag_category_id
      t.string :ident
      t.string :name
      t.integer :measure_category_id

      t.timestamps
    end
  end
end
