class IncensesController < ApplicationController
  before_action :login_required, only: :create

  validates :index do
    integer :page
  end

  def create
    if current_user.fire_incense
      render partial: "incenses/incenses",
             locals: {
               incenses: Incense.recent
                 .includes(:user).limit(Incense::TOP_VIEW_SIZE),
             },
             status: :created
    else
      head status: 409
    end
  end

  def index
    @incenses = Incense.recent.includes(:user).page(params[:page])
  end
end
