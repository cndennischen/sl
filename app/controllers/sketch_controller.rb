class SketchController < ApplicationController
  before_filter :require_signin
  before_filter :authorize_edit, :only => [:edit, :save, :rename, :sharing, :export]
  before_filter :get_sketch, :only => [:edit, :save, :rename, :sharing, :delete, :export]

  # Creates a new sketch
  def new
    if allow_new?
      begin
        @sketch = current_user.sketches.create!(:name => params[:name], :content => "{}")
        redirect_to "/edit/#{@sketch.id}"
      rescue
        # Oh no!
        redirect_to root_url, :alert => "Error creating sketch: #{$!}"
      end
    else
      flash[:error] = 'You cannot have more than one sketch on the basic plan. Upgrade to the premium plan to have unlimited sketches.'
      redirect_to root_url
    end
  end

  # The sketch editing page
  def edit
  end

  # The actual editing canvas, which is embedded in the edit page with an iframe
  def canvas
    @canvas = true # so the layout can know that it's the canvas
  end

  # Saves the specified sketch
  def save
    # Set the content of the sketch
    @sketch.update_attribute(:content, params[:data])
    render :nothing => true
  end

  # Changes the name of the specified sketch
  def rename
    @sketch.update_attributes(:name => params[:name])
    redirect_to "/edit/#{@sketch.id}"
  end

  # Changes the "public" attribute that allows a sketch to be viewed by anyone
  def sharing
    if params[:public]
      @sketch.public = true
    else
      @sketch.public = false
    end
    @sketch.save
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
    # Convert the sketch to the selected format
    case format
    when 'png', 'jpg'
      data = @sketch.to_img(format)
    when 'pdf'
      data = @sketch.to_pdf
    else
      return render_not_found
    end
    # Send the exported file to the user
    send_data(data, :filename => "sketch.#{format}")
  end

  # Sorts the sketches
  def sort
    sketches = current_user.sketches
    sketches.each do |sketch|
      sketch.position = params['sketch'].index(sketch.id.to_s) + 1
      sketch.save
    end
    render :nothing => true
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

  # Check if the user is allowed to edit sketches
  def authorize_edit
    unless allow_edit?
      flash[:error] = 'You are not allowed to have more than one sketch on the basic plan. Please <a href="/account">upgrade</a> to the premium plan or delete all of your extra sketches until you have only one sketch.'
      redirect_to root_url
    end
  end
end
