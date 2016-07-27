class AddFacebookPageUrlToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :facebook_page_url, :string
  end
end
