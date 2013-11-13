class TranslateAddresses < ActiveRecord::Migration
  def self.up

    Address.create_translation_table!({
                                          :addr => :text,
                                      }, {
                                          :migrate_data => true
                                      })
  end

  def self.down
    Address.drop_translation_table! :migrate_data => true
  end
end