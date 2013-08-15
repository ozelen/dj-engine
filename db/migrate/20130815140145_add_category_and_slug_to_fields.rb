class AddCategoryAndSlugToFields < ActiveRecord::Migration
  def change
    add_column :fields, :slug, :string
    add_column :fields, :field_category_id, :integer
    add_index :fields, :field_category_id
  end
end
