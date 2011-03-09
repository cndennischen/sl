class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    # only log out if a user is already logged in
    if !current_user
      redirect_to root_url
    else
      session[:user_id] = nil
      redirect_to signin_url, :notice => "Signed out!"
    end
  end

  def auth_error
    flash[:error] = "An error occured while signing you in: #{params[:message]}"
    redirect_to signin_url
  end

end
