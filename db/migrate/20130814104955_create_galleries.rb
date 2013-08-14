class CreateGalleries < ActiveRecord::Migration
  def up
    create_table :galleries do |t|
      t.string :name
      t.text :description
      t.integer :cover_photo_id
      t.belongs_to :imageable, polymorphic: true

      t.timestamps
    end
    add_index :galleries, [:imageable_id, :imageable_type]
  end

  def down
    drop_table :galleries
  end
end
