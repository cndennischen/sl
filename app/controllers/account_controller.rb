class AccountController < ApplicationController
  before_filter :require_login

  def index
    # declare instance variables
    @name = current_user.name
    @email = current_user.email
    @plan = current_user.plan
  end

  def update
    # make sure the user specified a name
    if params[:name].blank?
      flash[:error] = "Please specify a name"
    else
      # update the user's name
      current_user.name = params[:name]
      # attempt to save the user
      if current_user.save
        flash[:notice] = "Account updated!"
      else
        flash[:error] = "An error occured while trying to update your account. Please try again in a few minutes."
      end
    end
    # go back to the account page
    redirect_to account_path
  end

  def delete
  end

  def destroy
    # only delete account if user is not on paid plan
    if current_user.plan != "paid" and params[:confirmed]
      begin
        # destroy the user
        current_user.destroy
        # sign out
        session[:user_id] = nil
        flash[:notice] = "Your account has been deleted."
      rescue
        logger.warn("Error deleting account: #{$!}")
        flash[:error] = "An error occurred while trying to delete your account. Please try again in a few minutes."
      end
      redirect_to root_url
    else
      redirect_to delete_account_path, :notice => 'Please check the confirmation check box'
    end
  end
end
