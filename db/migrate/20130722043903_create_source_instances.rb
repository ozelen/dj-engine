class CreateSourceInstances < ActiveRecord::Migration
  def change
    create_table :source_instances do |t|
      t.string :name
      t.text :description
      t.integer :source_class_id
      t.integer :parent_instance_id

      t.timestamps
    end
  end
end
