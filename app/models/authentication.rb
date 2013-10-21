class Authentication < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :provider, :uid, :provider, :uid, :token

  def provider_name
    provider == 'open_id' ? 'OpenID' : provider.titleize
  end

end
