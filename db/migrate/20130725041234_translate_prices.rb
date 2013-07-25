class TranslatePrices < ActiveRecord::Migration
  def self.up
    Price.create_translation_table!({
                                       :description => :text
                                   }, {
                                       :migrate_data => true
                                   })
  end

  def self.down
    Price.drop_translation_table! :migrate_data => true
  end
end
