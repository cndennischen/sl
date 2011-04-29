class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
  rescue_from ActionView::MissingTemplate, :with => :render_not_found

  helper_method :current_user
  helper_method :mobile_device?
  helper_method :allow_new?
  helper_method :admin?

  before_filter :prepare_for_mobile

  private

  # Renders the 404 page
  def render_not_found
    render "#{Rails.root}/public/404.html", :status => 404, :layout => nil
  end

  # Checks if the current user is allowed to create another sketch.
  # Returns true if the current user has less than one sketch, or is not on the free plan.
  # This allows free users to have one sketch and paid users to have unlimited sketches.
  def allow_new?
    (current_user.sketches.size < 1) or (current_user.plan != 'free')
  end

  # Retrieves the currently logged in user
  def current_user
    begin
      # Include the sketches in the query unless we are in the AccountController, which
      # doesn't deal with sketches
      if params[:controller] == 'account'
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      else
        @current_user ||= User.find(session[:user_id], :include => :sketches) if session[:user_id]
      end
    rescue ActiveRecord::RecordNotFound
      session[:user_id] = nil
      flash[:error] = "Could not find your user account"
      redirect_to root_url
      return nil
    end
  end

  # Returns true if the current user is an admin
  def admin?
    current_user.admin?
  end

  # Returns true if the currently displayed site is the mobile version,
  # and false if it is the desktop version
  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/ # This Regular Expression can be improved to allow detection of more mobile devices
    end
  end

  # Determines if the site should be displayed in mobile format
  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end

  # Before filter to keep unauthenticated users from accessing protected or
  # user-specific pages
  def require_login
    unless current_user
      redirect_to signin_url, :notice => 'Please sign in to access that page'
    end
  end
end
