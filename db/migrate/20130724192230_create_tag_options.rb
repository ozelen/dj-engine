class CreateTagOptions < ActiveRecord::Migration
  def change
    create_table :tag_options do |t|
      t.integer :tag_name_id
      t.string :name

      t.timestamps
    end
  end
end
