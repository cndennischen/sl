class SketchController < ApplicationController
  before_filter :require_login
  before_filter :get_sketch, :only => [:edit, :save, :rename, :delete, :export]

  def new
    if allow_new
      begin
        @sketch = current_user.sketches.create!(:name => params[:name], :content => "{}")
        redirect_to "/edit/#{@sketch.id}"
      rescue
        redirect_to root_url, :error => "Error creating sketch: #{$!}"
      end
    else
      flash[:error] = 'You cannot have more than one sketch on the free plan. Upgrade to the paid plan to have unlimited sketches.'
      redirect_to root_url
    end
  end

  def edit
    @title = @sketch.name
  end

  def canvas
    @canvas = true # so the layout can know that it's the canvas
  end

  def save
    # set the content of the sketch
    @sketch.update_attributes(:content => params[:data])
    render :nothing => true
  end

  def rename
    @sketch.update_attributes(:name => params[:name])
    redirect_to "/edit/#{@sketch.id}"
  end

  def delete
    @sketch.destroy
    redirect_to root_url, :notice => 'Sketch deleted!'
  end

  def export
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

  def get_sketch
    @sketch = current_user.sketches.find(params[:id])
  end
end
