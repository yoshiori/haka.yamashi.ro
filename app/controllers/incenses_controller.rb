class IncensesController < ApplicationController
  before_action :login_required

  def create
    current_user.incenses.create
    render partial: "/root/incenses",
           locals: { incenses: Incense.recent.limit(Incense::TOP_VIEW_SIZE) },
           status: :created
  end

  private

  def login_required
    head status: 403 unless current_user
  end
end
