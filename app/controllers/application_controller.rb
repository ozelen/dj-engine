class ApplicationController < ActionController::Base
  protect_from_forgery

  #layout :layout_with_mercury
  helper_method :is_editing?

  before_filter :set_locale

  private

  def is_editing?
    cookies[:editing] == 'true' && can_edit?
  end

  def set_locale
    I18n.default_locale = 'ru'
    I18n.locale = params[:locale].present? ? params[:locale] : I18n.default_locale
    # current_user.locale
    # request.subdomain
    # request.env['HTTP_ACCEPT_LANGUAGE']
    # request.remote_ip
  end

  def default_url_options(options = {})
    {locale: I18n.locale}
  end


  def store_location
    #session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end

  def find_hotel
    @hotel = Node.find_by_name(params[:hotel_id]).accessible
  end

end
