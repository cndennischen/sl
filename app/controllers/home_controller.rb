class HomeController < ApplicationController
  # Displays the current users sketches if she is logged in, otherwise
  # displays information about Sketch Lab
  def index
    if current_user
      if admin?
        # If the user is an admin, get all the sketches in the database,
        # filtered by the search parameter
        @sketches = Sketch.search(params[:search])
      else
        # Get the current user's sketches, filtered by the search parameter
        @sketches = current_user.sketches.search(params[:search])
      end
      if current_user.plan != 'premium'
        @ad = Ad.find_by_name('list_bottom')
      end
    end
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

  # The Sketch Lab Terms of Service
  def tos
  end

  # The Sketch Lab Privacy Policy
  def privacy
  end
end
