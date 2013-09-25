class CreateSkiworldLegacies < ActiveRecord::Migration
  def change
    create_table :skiworld_legacies do |t|
      t.belongs_to :legatee, polymorphic: true
      t.integer :legator_id
      t.string :legator_table

      t.timestamps
    end

    add_index :skiworld_legacies, [:legatee_id, :legatee_type]
    add_index :skiworld_legacies, :legator_id
    add_index :skiworld_legacies, :legator_table

  end
end
