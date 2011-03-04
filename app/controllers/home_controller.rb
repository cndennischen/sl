class HomeController < ApplicationController
  before_filter :require_login, :except => [:index, :signin]
  before_filter :get_sketch, :only => [:save_sketch, :rename_sketch, :delete_sketch, :export_sketch]

  def index
  end

  def signin
  end

  def account
    @name = current_user.name
    @email = current_user.email
    @plan = current_user.plan
  end
  
  def delete_account
    # only delete account on POST request and if user is not on paid plan
    if request.request_method == :post and current_user.plan != "paid"
      if params[:confirmed]
        # TODO: destroy cuurrent user
        render :nothing => true
      else
        redirect_to account_path
      end
    end
  end

  def editor
    @sketch = current_user.sketches.find(params[:sketchID])
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
    unless logged_in?
      flash[:notice] = 'Please sign in to access that page'
      redirect_to signin_url
    end
  end

  def logged_in?
    !!current_user
  end

  def get_sketch
    @sketch = current_user.sketches.find(params[:id])
  end

end
