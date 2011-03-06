class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found

  helper_method :current_user
  helper_method :allow_new

  private

  def not_found
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => nil
  end

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
      session[:user_id] = nil
      flash[:error] = "Could not find your user account"
      redirect_to root_url
      return nil
    end
  end

  def allow_new
    if current_user.plan == "free" && current_user.sketches.count > 0
      return false
    else
      return true
    end
  end

end
