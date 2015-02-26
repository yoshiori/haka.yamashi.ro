class UsersController < ApplicationController
  def show
    @user = User.find_by(nickname: params[:nickname])
  end
end
