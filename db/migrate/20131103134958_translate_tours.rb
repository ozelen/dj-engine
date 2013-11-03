class TranslateTours < ActiveRecord::Migration
  def up
    Tour.create_translation_table!({
                                       :name  => :string,
                                       :title => :string,
                                       :description => :text
                                   }, {
                                       :migrate_data => true
                                   })
  end

  def down
    Tour.drop_translation_table! :migrate_data => true
  end
end
