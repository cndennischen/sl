class HomeController < ApplicationController
  before_filter :require_login, :except => [:index, :signin]
  before_filter :get_sketch, :only => [:save_sketch, :rename_sketch, :delete_sketch, :export_sketch]
  verify :method => :post, :only => [:new_sketch, :save_sketch, :rename_sketch, :delete_sketch]

  def editor
  end

  def new_sketch
    if allow_new
      @sketch = current_user.sketches.create!(:name => params[:name], :content => "{}")
      redirect_to "/edit/#{@sketch.id}"
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
