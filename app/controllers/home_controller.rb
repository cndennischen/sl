class HomeController < ApplicationController
  before_filter :require_login, :except => [:index, :signin]
  before_filter :get_sketch, :only => [:save_sketch, :rename_sketch, :delete_sketch, :export_sketch]
  verify :method => :post, :only => [:new_sketch, :save_sketch, :rename_sketch, :delete_sketch]

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
    @sketch.content = params[:data]
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
    # get a hash from the sketch's content
    content = JSON.parse(@sketch.content)
    # check which format the user wants the sketch in
    case params[:format]
    when 'svg'
      svg(content)
    when 'png'
      png(content)
    when 'jpeg'
      jpeg(content)
    when 'pdf'
      # TODO: redirect to a url for getting the pdf version of the sketch
    end
  end

  private

  # Export to...

  def svg(content)
  end
  def png(content)
  end
  def jpeg(content)
  end

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
