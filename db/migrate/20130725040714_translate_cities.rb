class TranslateCities < ActiveRecord::Migration
  def self.up
    City.create_translation_table!({
                                       :name => :string,
                                       :description => :text
                                   }, {
                                       :migrate_data => true
                                   })
  end

  def self.down
    City.drop_translation_table! :migrate_data => true
  end
end
