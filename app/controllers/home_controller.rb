class HomeController < ApplicationController
  before_filter :require_login, :except => [:index, :signin]
  verify :method => :post, :except => [:index, :signin, :editor]

  def new_sketch
    if allow_new
      s = current_user.sketches.create!(:name => params[:name], :content => "{}")
      redirect_to "/edit/#{s.id}"
    else
      flash[:error] = "You cannot have more than one sketch on the free plan. Upgrade to the paid plan to have multiple sketches."
      redirect_to root_url
    end
  end
  
  def save_sketch
    s = current_user.sketches.find(params[:id])
    # set the content of the sketch
    s.content = params[:data]
    s.save
    render :nothing => true
  end

  def rename_sketch
    s = current_user.sketches.find(params[:id])
    s.name = params[:newName]
    s.save
    redirect_to "/edit/#{s.id}"
  end

  def delete_sketch
    s = current_user.sketches.find(params[:id])
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
