class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.date :since
      t.date :till
      t.string :name
      t.string :description
      t.integer :order_position
      t.integer :hotel_id

      t.timestamps
    end
  end
end
