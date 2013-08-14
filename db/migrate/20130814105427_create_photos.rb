class CreatePhotos < ActiveRecord::Migration
  def up
    create_table :photos do |t|
      t.string :image
      t.string :description
      t.belongs_to :gallery

      t.timestamps
    end
    add_index :photos, :gallery_id
  end

  def down
    drop_table :photos
  end
end
