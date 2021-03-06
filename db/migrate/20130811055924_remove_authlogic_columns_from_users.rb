class RemoveAuthlogicColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :crypted_password
    remove_column :users, :password_salt
    remove_column :users, :persistence_token
    remove_column :users, :login_count
    remove_column :users, :last_request_at
    remove_column :users, :last_login_at
    remove_column :users, :current_login_at
    remove_column :users, :last_login_ip
    remove_column :users, :current_login_ip
  end

end
