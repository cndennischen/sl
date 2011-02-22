class IpnsController < ApplicationController
  protect_from_forgery :except => [:create]

  def create
    Ipn.create!(:params => params, :user_id => params[:custom])
    render :nothing => true
  end
end
