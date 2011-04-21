class SessionsController < ApplicationController
  # Signs the current user in with OmniAuth
  def create
    # Get the authentication information from OmniAuth
    auth = request.env["omniauth.auth"]
    # Fetch the user from the database
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
    # If the user exists, sign her in
    if user
      flash[:notice] = "Signed In!"
    else
      # If it's a new user, sign her up
      user = User.create_with_omniauth(auth)
      flash[:notice] = "Signed Up!"
    end
    # Set the session user_id variable to the current user's id
    session[:user_id] = user.id
    # Go back to home page
    redirect_to root_url
  end

  # Signs the current user out
  def destroy
    session[:user_id] = nil
    redirect_to signin_url, :notice => "Signed out!"
  end

  # This method is called when OmniAuth encounters an error signing the user in
  def auth_error
    flash[:error] = "An error occured while signing you in: #{params[:message]}"
    redirect_to signin_url
  end

end
