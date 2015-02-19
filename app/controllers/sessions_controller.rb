class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    session[:user_id] = User.find_or_create_from_auth_hash(auth).id
    redirect_to root_url, notice: "signtin"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "signout"
  end
end
