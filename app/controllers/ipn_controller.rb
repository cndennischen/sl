class IpnController < ApplicationController
  protect_from_forgery :except => [:create]
  
  def create
    # create a new Ipn record
    Ipn.create!(:params => params, :status => params[:payment_status], :user_id => User.where("email = ?", params[:payer_email]).id);
    # no need to render anything
    render :nothing => true
  end

end
