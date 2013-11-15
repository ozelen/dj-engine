class CreateRedirects < ActiveRecord::Migration
  def change
    create_table :redirects do |t|
      t.string :old_domain
      t.string :old_path
      t.string :new_path

      t.timestamps
    end

    add_index :redirects, :old_domain
    add_index :redirects, :old_path
    add_index :redirects, :new_path

  end
end
