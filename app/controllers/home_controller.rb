class HomeController < ApplicationController
  before_filter :require_login, :only => [:editor, :new_sketch]
  def index
  end
  
  def new_sketch
    current_user.sketches.create!(:name => "Untitled Sketch", :content => "{}")
    flash[:notice] = "Sketch created!"
    redirect_to root_url
  end
  
  def editor
    data = getSketch(params[:id])
  end
  
  private

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to create or edit sketches"
      redirect_to root_url
    end
  end
  
  def logged_in?
    !!current_user
  end
  
  def getSketch(id)
    # get the user's sketches
    data = current_user.sketches
    if data.has_key? id
      return data[id]
    else
      flash[:error] = "The selected sketch doesn't exist"
      redirect_to root_url
    end
  end
  
end
