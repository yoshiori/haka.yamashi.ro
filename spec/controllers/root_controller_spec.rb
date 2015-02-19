require "rails_helper"

describe RootController do
  describe "#index" do
    it do
      get :index
      expect(assigns(:incenses).size).to_not be_nil 
    end
  end
end
