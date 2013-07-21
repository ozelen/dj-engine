class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :email
      t.string :first_name
      t.srting :last_name
      t.text :address
      t.string :phone
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
