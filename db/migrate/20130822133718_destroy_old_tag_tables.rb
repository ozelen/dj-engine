class DestroyOldTagTables < ActiveRecord::Migration
  def change
    drop_table :tags
    drop_table :tag_categories
    drop_table :tag_names
    drop_table :tag_options
  end
end
