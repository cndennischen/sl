class HomeController < ApplicationController
  caches_page :contributing

  # Displays the current users sketches if she is logged in, otherwise
  # displays information about Sketch Lab
  def index
    # Get the current user's sketches, filtered by the search parameter
    @sketches = current_user.sketches.search(params[:search]) if current_user
  end

  # The sign in page
  def signin
    # Go back home if user is already logged in
    if current_user
      redirect_to root_url
    end

    respond_to do |format|
      format.html # signin.html.erb

      # On the mobile site, the homepage serves as the signin page
      format.mobile { redirect_to root_url, :notice => flash[:notice] }
    end
  end

  # Displays information about how to contribute to the source code
  def contributing
  end
end
