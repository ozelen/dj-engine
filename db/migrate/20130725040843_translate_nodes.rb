class TranslateNodes < ActiveRecord::Migration
  def self.up
    Node.create_translation_table!({
                                       :header => :string,
                                       :title => :string,
                                       :content => :text
                                   }, {
                                       :migrate_data => true
                                   })
  end

  def self.down
    Node.drop_translation_table! :migrate_data => true
  end
end
