class HomeController < ApplicationController
  def index
    if current_user
      if !mobile_device?
        # get the user's sketches, filtered by the search parameter
        @sketches = current_user.sketches.search(params[:search])
      else
        # get all the users sketches
        @sketches = current_user.sketches
      end
    end
  end

  def signin
    respond_to do |format|
      format.html
      format.mobile { return redirect_to root_url, :notice => flash[:notice] }
    end

    # go back home if user is already logged in
    if current_user
      redirect_to root_url
    end
  end

  def contributing
  end

  def account
    # declare instance variables
    @name = current_user.name
    @email = current_user.email
    @plan = current_user.plan
  end

  def update_account
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

  def destroy_account
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
