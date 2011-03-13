class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
    if user
      flash[:notice] = "Signed In!"
    else
      user = User.create_with_omniauth(auth)
      flash[:notice] = "Signed Up!"
    end
    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to signin_url, :notice => "Signed out!"
  end

  def auth_error
    flash[:error] = "An error occured while signing you in: #{params[:message]}"
    redirect_to signin_url
  end

end
