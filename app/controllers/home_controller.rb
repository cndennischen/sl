class HomeController < ApplicationController
  def index
    if current_user
      if !mobile_device?
        # get the user's sketches, filtered by the search parameter
        @sketches = current_user.sketches.search(params[:search])
      else
        # get all the users sketches
        @sketches = current_user.sketches
      end
    end
  end

  def signin
    respond_to do |format|
      format.html
      format.mobile { return redirect_to root_url, :notice => flash[:notice] }
    end

    # go back home if user is already logged in
    if current_user
      redirect_to root_url
    end
  end

  def contributing
  end
end
