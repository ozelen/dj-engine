class TranslateFieldCategories < ActiveRecord::Migration
  def self.up
    FieldCategory.create_translation_table!({
                                       :name => :string,
                                   }, {
                                       :migrate_data => true
                                   })
  end

  def self.down
    FieldCategory.drop_translation_table! :migrate_data => true
  end
end
