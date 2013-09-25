class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :email
      t.string :website
      t.string :phone1
      t.string :phone2
      t.string :phone3
      t.string :fax
      t.string :skype
      t.text :address
      t.belongs_to :addressable, polymorphic: true

      t.timestamps
    end
    add_index :addresses, [:addressable_id, :addressable_type]
  end

  def self.down
    drop_table :addresses
  end
end
