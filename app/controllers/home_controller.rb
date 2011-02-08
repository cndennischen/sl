class HomeController < ApplicationController
  before_filter :require_login, :only => [:editor]
  def index
  end
  
  private

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to edit sketches"
      redirect_to root_url
    end
  end
  
  def logged_in?
    !!current_user
  end
  
  def getSketch(id)
    # get the users sketches
    data = JSON.parse(current_user.sketches)
    if result.has_key? "id"
      return data["id"]
    end
  end
  
end
