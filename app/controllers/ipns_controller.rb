class IpnsController < ApplicationController
  protect_from_forgery :except => [:create]
  
  def create
    Ipn.create!(:params => params, :user_id => params[:custom], :status => params[:payment_status], :transaction_id => params[:txn_id])
    render :nothing => true
  end
end
