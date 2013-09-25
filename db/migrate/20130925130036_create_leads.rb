class CreateLeads < ActiveRecord::Migration
  def self.up
    create_table :leads do |t|
      t.string :provider
      t.belongs_to :leader, polymorphic: true
      t.string :params

      t.timestamps
    end
    add_index :leads, [:leader_id, :leader_type]
    add_index :leads, :provider
    add_index :leads, :params
  end

  def self.down
    drop_table :leads
  end
end
