class CreatePosts < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.string :slug
      t.string :title
      t.text :teaser
      t.text :content
      t.belongs_to :channel, polymorphic: true
      t.belongs_to :user

      t.timestamps
    end
    add_index :posts, :user_id
    add_index :posts, [:channel_id, :channel_type]
  end
  def down
    drop_table :posts
  end
end
