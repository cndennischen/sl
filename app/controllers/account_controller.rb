class AccountController < ApplicationController
  before_filter :require_login, :except => :current

  # JavaScript code for updating the user-specific dynamic content on
  # the page. Using JavaScript for this allows the use of page caching
  # while still having dynamic content.
  def current
    # current.js.erb
  end

  # Displays the current user's info and allows her to change her name
  def index
    # Declare instance variables
    @name = current_user.name
    @email = current_user.email
    @plan = current_user.plan
  end

  # Updates the current user's name
  def update
    # Make sure the user specified a name
    if params[:name].blank?
      flash[:error] = "Please specify a name"
    else
      # Update the user's name
      current_user.name = params[:name]
      # Attempt to save the user
      if current_user.save
        flash[:notice] = "Account updated!"
      else
        flash[:error] = "An error occured while trying to update your account. Please try again in a few minutes."
      end
    end
    # Go back to the account page
    redirect_to account_path
  end

  # Displays a confirmation page for deleting the current user
  def delete
  end

  # Permanently deletes the current user
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
