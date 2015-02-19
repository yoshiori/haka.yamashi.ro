class RootController < ApplicationController
  def index
    @incenses = Incense.recent
  end
end
