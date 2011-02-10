class HomeController < ApplicationController
  before_filter :require_login, :except => [:index]
  def index
  end
  
  def new_sketch
    s = current_user.sketches.create!(:name => params[:name], :content => "{}")
    redirect_to "/edit/#{s.id}"
  end

  def delete_sketch
    Sketch.destroy(params[:id])
    redirect_to root_url
  end
  
  private

  def require_login
    unless logged_in?
      flash[:error] = "You must be signed in to create, edit or delete sketches"
      redirect_to root_url
    end
  end
  
  def logged_in?
    !!current_user
  end
  
end
