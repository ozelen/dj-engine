class CreateSourceClasses < ActiveRecord::Migration
  def change
    create_table :source_classes do |t|
      t.string :name
      t.text :description
      t.integer :parent_id
      t.integer :parent_class_id

      t.timestamps
    end
  end
end
