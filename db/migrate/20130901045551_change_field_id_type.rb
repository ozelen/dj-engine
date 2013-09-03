class ChangeFieldIdType < ActiveRecord::Migration
  def up
    change_column :values, :field_id, :integer
    change_column :values, :measure_id, :integer
  end

  def down
    change_column :values, :field_id, :string
    change_column :values, :measure_id, :string
  end
end
