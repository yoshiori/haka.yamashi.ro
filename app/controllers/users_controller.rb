class UsersController < ApplicationController
  before_action :login_required, only: :create_token

  validates :show do
    integer :page
  end

  def show
    @user = User.find_by(nickname: params[:nickname])
    @incenses = @user.incenses.recent.page(params[:page])
  end

  def create_token
    current_user.create_token
    render partial: "users/token", status: :created
  end
end
