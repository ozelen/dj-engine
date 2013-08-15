class CreateFieldCategories < ActiveRecord::Migration
  def change
    create_table :field_categories do |t|
      t.string :name
      t.string :slug
      t.belongs_to :type

      t.timestamps
    end
    add_index :field_categories, :type_id
  end
end
