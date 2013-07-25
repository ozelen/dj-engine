class TranslateHotels < ActiveRecord::Migration
  def self.up
    Hotel.create_translation_table!({
                                       :name => :string,
                                       :description => :text
                                   }, {
                                       :migrate_data => true
                                   })
  end

  def self.down
    Hotel.drop_translation_table! :migrate_data => true
  end
end
