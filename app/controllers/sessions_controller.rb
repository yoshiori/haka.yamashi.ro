class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    puts auth
    redirect_to root_url, notice: "login"
  end
end
