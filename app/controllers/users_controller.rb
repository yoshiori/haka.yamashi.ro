class UsersController < ApplicationController
  def show
    @user = User.find_by(nickname: params[:nickname])
    @incenses = @user.incenses.recent.page(params[:page])
  end
end
