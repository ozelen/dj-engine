class TranslateRooms < ActiveRecord::Migration
  def self.up
    Room.create_translation_table!({
                                        :name => :string,
                                        :description => :text
                                    }, {
                                        :migrate_data => true
                                    })
  end

  def self.down
    Room.drop_translation_table! :migrate_data => true
  end
end
