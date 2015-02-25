class UsersController < ApplicationController
  def show
    @user = User.find_by(nickname: params[:id])
  end
end
