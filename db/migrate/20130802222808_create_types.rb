class CreateTypes < ActiveRecord::Migration
  def up
    create_table :types do |t|
      t.string :name
      t.string :filter

      t.timestamps
    end
  end

  def down
    drop_table :types
  end
end