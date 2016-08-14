class HomeController < ActionController::Base
  before_filter :set_params
  def robots
    render formats: :text
  end

  def sitemap
    render formats: :xml
  end

  def set_params
    @domain = request.host
  end

end