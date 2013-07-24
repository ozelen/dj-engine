class CreateTagCategories < ActiveRecord::Migration
  def change
    create_table :tag_categories do |t|
      t.integer :parent_id
      t.string :filter
      t.string :name

      t.timestamps
    end
  end
end
