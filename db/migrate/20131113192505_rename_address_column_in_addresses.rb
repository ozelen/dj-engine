class RenameAddressColumnInAddresses < ActiveRecord::Migration
  def up
    remove_column :addresses, :address
    add_column :addresses, :addr, :text
  end

  def down
    remove_column :addresses, :addr
    add_column :addresses, :address, :text
  end
end
