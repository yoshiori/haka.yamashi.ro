class IncensesController < ApplicationController
  before_action :login_required, only: :create

  def create
    if current_user.fire_incense
      render partial: "incenses/incenses",
             locals: { incenses: Incense.recent.includes(:user).limit(Incense::TOP_VIEW_SIZE) },
             status: :created
    else
      head status: 409
    end
  end

  def index
    @incenses = Incense.all.recent.page(params[:page])
  end

  private

  def login_required
    head status: 403 unless current_user
  end
end
