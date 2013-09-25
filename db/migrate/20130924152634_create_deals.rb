class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.belongs_to :dealable, polymorphic: true
      t.string :person_name
      t.string :login
      t.string :password
      t.integer :price
      t.date :begin_date
      t.date :expire_date
      t.text :contacts
      t.integer :status

      t.timestamps
    end

    add_index :deals, [:dealable_id, :dealable_type]
    add_index :deals, :person_name
    add_index :deals, :price
    add_index :deals, :begin_date
    add_index :deals, :expire_date
    add_index :deals, :status
  end
end
