class RegistrationsController < Devise::RegistrationsController
  def create
    if session[:omniauth] == nil
      if verify_recaptcha
        super
        session['devise.oauth_data'] = nil unless @user.new_record?
      else
        build_resource
        clean_up_passwords(resource)
        flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."
        flash.delete :recaptcha_error
        render :new
      end
    else
      super
      session['devise.oauth_data'] = nil unless @user.new_record?
    end
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
