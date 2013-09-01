class AddValueBooleanToValues < ActiveRecord::Migration
  def up
    add_column :values, :value_boolean, :boolean
  end
  def down
    remove_column :values, :value_boolean
  end
end
