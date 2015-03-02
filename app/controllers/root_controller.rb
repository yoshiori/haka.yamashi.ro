class RootController < ApplicationController
  def index
    @incenses = Incense.recent.includes(:user).limit(Incense::TOP_VIEW_SIZE)
  end
end
