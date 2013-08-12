class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def persist
    #render text: @user.id.inspect
    auth = request.env["omniauth.auth"]
    if @user.persisted? || @user.save
      @user.authentications.find_or_create_by_provider_and_uid( provider:auth.provider, uid:auth.uid )
      set_flash_message(:notice, :success, :kind => auth.provider.titleize) if is_navigational_format?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    else
      #session["devise.facebook_data"] = auth
      session['devise.oauth_data'] = auth.except(:extra)
      #render text: @user.to_yaml
      #render text: auth.to_yaml
      redirect_to new_user_registration_url
    end
  end

  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    #render text: @user.inspect
    persist
  end

  def vkontakte
    @user = User.find_for_vk_oauth(request.env["omniauth.auth"], current_user)
    persist
  end

  def twitter
    debug
  end


  def debug
    render text: request.env["omniauth.auth"].to_yaml
  end

end