class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.integer :room_id
      t.integer :period_id
      t.integer :value
      t.integer :measure_id
      t.string :description

      t.timestamps
    end
  end
end
