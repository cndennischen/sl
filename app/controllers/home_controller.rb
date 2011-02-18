class HomeController < ApplicationController
  before_filter :require_login, :except => [:index, :signin]
  
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

  def to_pdf
    s = current_user.sketches.find(params[:id])
    # generate a pdf version of the sketch
    pdfPath = "tmp/#{s.id}.pdf"
    Prawn::Document.generate(pdfPath) do |pdf| 
      pdf.text(s.name, :size => 16, :style => :bold)
      pdf.move_down(15)
    end
    # send the file to the user
    send_file pdfPath, :type => 'application/pdf'
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
