class HomeController < ApplicationController
  before_filter :require_login, :except => [:index, :signin, :contributing]
  before_filter :get_sketch, :only => [:save_sketch, :rename_sketch, :delete_sketch, :export_sketch]

  def index
    @sketches = current_user.sketches.search(params[:search]) if current_user
  end

  def signin
    # go back home if user is already logged in
    if current_user
      redirect_to root_url
    end
    
    respond_to do |format|
      format.html
      format.mobile { redirect_to root_url }
    end
  end

  def contributing
  end

  def account
    # declare instance variables
    @name = current_user.name
    @email = current_user.email
    @plan = current_user.plan
  end
  
  def update_account
    # make sure the user specified a name
    if params[:name].blank?
      flash[:error] = "Please specify a name"
    else
      # update the user's name
      current_user.name = params[:name]
      # attempt to save the user
      if current_user.save
        flash[:notice] = "Account updated!"
      else
        flash[:error] = "An error occured while trying to update your account. Please try again in a few minutes."
      end
    end
    # go back to the account page
    redirect_to account_path
  end

  def delete_account
  end

  def destroy_account
    # only delete account if user is not on paid plan
    if current_user.plan != "paid" and params[:confirmed]
      begin
        # destroy the user
        current_user.destroy
        # sign out
        session[:user_id] = nil
        flash[:notice] = "Your account has been deleted."
      rescue
        logger.warn("Error deleting account: #{$!}")
        flash[:error] = "An error occurred while trying to delete your account. Please try again in a few minutes."
      end
      redirect_to root_url
    else
      flash[:notice] = "Please check the confirmation check box"
      redirect_to delete_account_path
    end
  end

  def editor
    @sketch = current_user.sketches.find(params[:sketchID])
  end
  
  def canvas
    @canvas = true # so the layout can know that it's the canvas
  end

  def new_sketch
    if allow_new
      begin
        @sketch = current_user.sketches.create!(:name => params[:name], :content => "{}")
        redirect_to "/edit/#{@sketch.id}"
      rescue
        flash[:error] = "Error creating sketch: #{$!}"
        redirect_to root_url
      end
    else
      flash[:error] = "You cannot have more than one sketch on the free plan. Upgrade to the paid plan to have multiple sketches."
      redirect_to root_url
    end
  end

  def save_sketch
    # set the content of the sketch
    @sketch.content = params[:data].gsub(/'/, "\\\\'")
    @sketch.save
    render :nothing => true
  end

  def rename_sketch
    @sketch.name = params[:name]
    @sketch.save
    redirect_to "/edit/#{@sketch.id}"
  end

  def delete_sketch
    @sketch.destroy
    flash[:notice] = "Sketch deleted!"
    redirect_to root_url
  end

  def export_sketch
    format = params[:format]
    # export the sketch to the selected format
    case format
    when 'png', 'jpg'
      data = @sketch.to_img(format)
    when 'pdf'
      data = @sketch.to_pdf
    else
      return not_found
    end
    # send the exported file to the user
    send_data(data, :filename => "sketch.#{format}")
  end

  private

  # Before filters

  def require_login
    unless current_user
      flash[:notice] = 'Please sign in to access that page'
      redirect_to signin_url
    end
  end

  def get_sketch
    @sketch = current_user.sketches.find(params[:id])
  end

end
