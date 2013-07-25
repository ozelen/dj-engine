class CreateAssignments < ActiveRecord::Migration
  def up
    create_table :assignments do |t|
      t.integer :user_id
      t.belongs_to :assigned, polymorphic: true
      t.string :role

      t.timestamps
    end
    add_index :assignments, [:assigned_id, :assigned_type]
  end

  def down
    drop_table :assignments
  end
end
