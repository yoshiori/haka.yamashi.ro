class RootController < ApplicationController
  def index
    @incenses = Incense.recent.limit(Incense::TOP_VIEW_SIZE)
  end
end
