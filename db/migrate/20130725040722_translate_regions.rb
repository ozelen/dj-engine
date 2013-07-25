class TranslateRegions < ActiveRecord::Migration
  def self.up
    Region.create_translation_table!({
                                       :name => :string,
                                       :description => :text
                                   }, {
                                       :migrate_data => true
                                   })
  end

  def self.down
    Region.drop_translation_table! :migrate_data => true
  end
end
