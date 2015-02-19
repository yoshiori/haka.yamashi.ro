class IncensesController < ApplicationController
  before_action :login_required

  def create
    current_user.incenses.create
    head status: :created
  end

  private

  def login_required
    head status: 403 unless current_user
  end
end
