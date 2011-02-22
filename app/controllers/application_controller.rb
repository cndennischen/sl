class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  helper_method :current_user
  helper_method :allow_new

  private

  def record_not_found
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => nil
  end

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
