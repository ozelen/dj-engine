class ChangeFieldIdType < ActiveRecord::Migration
  def up
    #change_column :values, :field_id, :integer # doesn't work on heroku
    #change_column :values, :measure_id, :integer
    remove_column :values, :field_id
    remove_column :values, :measure_id
    add_column :values, :field_id, :integer
    add_column :values, :measure_id, :integer
  end

  def down
    #change_column :values, :field_id, :string
    #change_column :values, :measure_id, :string
  end
end
