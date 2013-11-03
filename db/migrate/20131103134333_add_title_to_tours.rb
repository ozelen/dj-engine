class AddTitleToTours < ActiveRecord::Migration
  def up
    add_column :tours, :title, :string
  end

  def down
    remove_column :tours, :title
  end
end
