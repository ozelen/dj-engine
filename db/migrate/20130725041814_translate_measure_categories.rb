class TranslateMeasureCategories < ActiveRecord::Migration
  def self.up
    MeasureCategory.create_translation_table!({
                                          :name => :string,
                                      }, {
                                          :migrate_data => true
                                      })
  end

  def self.down
    MeasureCategory.drop_translation_table! :migrate_data => true
  end
end
