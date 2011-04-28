class SketchController < ApplicationController
  before_filter :require_login
  before_filter :get_sketch, :only => [:edit, :save, :rename, :delete, :export]

  # Creates a new sketch
  def new
    if allow_new?
      begin
        @sketch = current_user.sketches.create!(:name => params[:name], :content => "{}")
        redirect_to "/edit/#{@sketch.id}"
      rescue
        # Oh no!
        redirect_to root_url, :error => "Error creating sketch: #{$!}"
      end
    else
      flash[:error] = 'You cannot have more than one sketch on the free plan. Upgrade to the paid plan to have unlimited sketches.'
      redirect_to root_url
    end
  end

  # The sketch editing page
  def edit
    @title = @sketch.name
  end

  # The actual editing canvas, which is embedded in the edit page with an iframe
  def canvas
    @canvas = true # so the layout can know that it's the canvas
  end

  # Saves the specified sketch
  def save
    # set the content of the sketch
    @sketch.update_attributes(:content => params[:data])
    render :nothing => true
  end

  # Changes the name of the specified sketch
  def rename
    @sketch.update_attributes(:name => params[:name])
    redirect_to "/edit/#{@sketch.id}"
  end

  # Deletes the specified sketch
  def delete
    @sketch.destroy
    redirect_to root_url, :notice => 'Sketch deleted!'
  end

  # Exports the specified sketch to the specified format
  def export
    format = params[:format]
    # export the sketch to the selected format
    case format
    when 'png', 'jpg'
      data = @sketch.to_img(format)
    when 'pdf'
      data = @sketch.to_pdf
    else
      return render_not_found
    end
    # send the exported file to the user
    send_data(data, :filename => "sketch.#{format}")
  end

  private

  # Before filters

  # Retrieve the specified sketch
  def get_sketch
    if admin?
      # The admin has access to all the sketches in the database
      @sketch = Sketch.find(params[:id])
    else
      @sketch = current_user.sketches.find(params[:id])
    end
  end
end
