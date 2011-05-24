class AccountController < ApplicationController
  before_filter :require_login

  # Displays the current user's info and allows her to change her name
  def index
  end

  # Delete the cached plan value
  def refresh_plan
    current_user.refresh_plan!
    redirect_to account_path
  end

  # Updates the current user's name
  def update
    # Update the user's name
    current_user.name = params[:name]
    # Attempt to save the user
    if current_user.save
      flash[:notice] = "Account updated!"
    else
      flash[:error] = "An error occured while updating your account. Please try again in a few minutes."
    end
    # Go back to the account page
    redirect_to account_path
  end

  # Displays a confirmation page for deleting the current user
  def delete
  end

  # Permanently deletes the current user
  def destroy
    # Delete the cached copy of the user's plan to make sure the user isn't on the premium plan
    current_user.refresh_plan!
    # Only delete account if user is not on premium plan
    if current_user.plan != 'premium' and params[:confirmed]
      begin
        # Destroy the user
        current_user.destroy
        # Sign out
        session[:user_id] = nil
        flash[:notice] = "Your account has been deleted."
      rescue
        logger.warn("Error deleting account: #{$!}")
        flash[:error] = "An error occurred while deleting your account. Please try again in a few minutes."
      end
      redirect_to root_url
    else
      redirect_to delete_account_path, :notice => 'Please confirm that you want to delete your account'
    end
  end
end
