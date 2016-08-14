class HomeController < ActionController::Base
  def robots
    render 'robots.txt'
  end
end