class HomeController < ApplicationController
  before_filter :require_login, :except => [:index]
  def index
  end
  
  def new_sketch
    s = current_user.sketches.create!(:name => params[:name], :content => "{}")
    redirect_to "/edit/#{s.id}"
  end
  
  def save_sketch
    s = Sketch.find(params[:id])
    # make sure the sketch belongs to the current user
    if s.user_id != current_user.id
      flash[:error] = "You don't own the selected sketch"
      redirect_to root_url
      return
    end
    # set the content of the sketch
    s.content = params[:data]
    s.save
    render :nothing => true
  end

  def rename_sketch
    s = Sketch.find(params[:id])
    # make sure the sketch belongs to the current user
    if s.user_id != current_user.id
      flash[:error] = "You don't own the selected sketch"
      redirect_to root_url
      return
    end
    s.name = params[:newName]
    s.save
    redirect_to "/edit/#{s.id}"
  end

  def delete_sketch
    s = Sketch.find(params[:id])
    # make sure the sketch belongs to the current user
    if s.user_id != current_user.id
      flash[:error] = "You don't own the selected sketch"
      redirect_to root_url
      return
    end
    s.destroy
    flash[:notice] = "Sketch deleted!"
    redirect_to root_url
  end
  
  private

  def require_login
    unless logged_in?
      flash[:error] = "You must be signed in to access that page"
      redirect_to root_url
    end
  end
  
  def logged_in?
    !!current_user
  end
  
end
