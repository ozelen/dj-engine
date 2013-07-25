class TranslateServices < ActiveRecord::Migration
  def self.up
    Service.create_translation_table!({
                                       :name => :string,
                                       :description => :text
                                   }, {
                                       :migrate_data => true
                                   })
  end

  def self.down
    Service.drop_translation_table! :migrate_data => true
  end
end
