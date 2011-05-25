class ApplicationController < ActionController::Base
  protect_from_forgery
  unless Rails.application.config.consider_all_requests_local
    rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
    rescue_from ActionView::MissingTemplate, :with => :render_not_found
  end

  helper_method :current_user, :mobile_device?, :allow_new?, :admin?

  before_filter :prepare_for_mobile

  private

  # Renders the 404 page
  def render_not_found
    render "#{Rails.root}/public/404.html", :status => 404, :layout => nil
  end

  # Checks if the current user is allowed to create another sketch.
  # Returns true if the current user has less than one sketch, or is not on the basic plan.
  # This allows basic users to have one sketch and premium users to have unlimited sketches.
  def allow_new?
    (current_user.sketches.size < 1) or (current_user.plan != 'basic')
  end

  # Checks if the current user is allowed to edit sketches.
  # Returns false if the user is on the basic plan and has more than one sketch.
  # This can happen (for example) if the user downgraded from the premium plan after
  # creating multiple sketches. In such a case, the user will not be allowed to
  # edit sketches until she deletes all of her extra sketches.
  def allow_edit?
    (current_user.sketches.size <= 1) or (current_user.plan != 'basic')
  end

  # Retrieves the currently logged in user
  def current_user
    begin
      # Include the sketches in the query if we are in a controller that deals with them
      if params[:controller] == 'sketch' || params[:controller] == 'home'
        @current_user ||= User.find(session[:user_id], :include => :sketches) if session[:user_id]
      else
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
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
