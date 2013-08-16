class TranslateFields < ActiveRecord::Migration
  def self.up
    Field.create_translation_table!({
                                       :name => :string,
                                   }, {
                                       :migrate_data => true
                                   })
  end

  def self.down
    Field.drop_translation_table! :migrate_data => true
  end
end
