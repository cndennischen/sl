class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  helper_method :allow_new

  private
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def allow_new
    if current_user.plan == "free" && current_user.sketches.count > 0
      return false
    else
      return true
    end
  end
  
end
