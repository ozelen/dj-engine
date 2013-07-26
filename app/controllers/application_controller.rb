class ApplicationController < ActionController::Base
  protect_from_forgery

  include Mercury::Authentication

  #layout :layout_with_mercury
  helper_method :is_editing?

  before_filter :set_locale

  helper_method :current_user

  private

  def layout_with_mercury
    !params[:mercury_frame] && is_editing? ? 'mercury' : 'application'
  end

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

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end


  def require_user
    #logger.debug "ApplicationController::require_user"
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to login_url
      return false
    end
  end

  def require_no_user
    #logger.debug "ApplicationController::require_no_user"
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      # redirect_to home_index_path
      return false
    end
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
