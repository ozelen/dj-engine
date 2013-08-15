class RegistrationsController < Devise::RegistrationsController
  def create
    super
    session['devise.oauth_data'] = nil unless @user.new_record?
  end

  private

  def build_resource(*args)
    super
    if session['devise.oauth_data']
      @user.apply_omniauth(session['devise.oauth_data'])
      @user.valid?
    end
  end
end
