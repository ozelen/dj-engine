class TranslateMeasures < ActiveRecord::Migration
  def self.up
    Measure.create_translation_table!({
                                       :name => :string,
                                   }, {
                                       :migrate_data => true
                                   })
  end

  def self.down
    Measure.drop_translation_table! :migrate_data => true
  end
end
