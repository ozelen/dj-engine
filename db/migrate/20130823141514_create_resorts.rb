class CreateResorts < ActiveRecord::Migration
  def change
    create_table :resorts do |t|
      t.belongs_to :type
      t.timestamps
    end
  end
end
