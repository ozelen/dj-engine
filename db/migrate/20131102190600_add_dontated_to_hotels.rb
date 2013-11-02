class AddDontatedToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :donated, :integer
    add_column :hotels, :deal_expire, :date
    add_index :hotels, :donated
    add_index :hotels, :deal_expire
  end
end
