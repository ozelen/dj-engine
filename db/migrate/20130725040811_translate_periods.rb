class TranslatePeriods < ActiveRecord::Migration
  def self.up
    Period.create_translation_table!({
                                       :name => :string,
                                   }, {
                                       :migrate_data => true
                                   })
  end

  def self.down
    Period.drop_translation_table! :migrate_data => true
  end
end
