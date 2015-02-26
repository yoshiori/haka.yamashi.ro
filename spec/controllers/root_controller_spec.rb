require "rails_helper"

describe RootController do
  describe "GET index" do
    it "assigns @incenses" do
      get :index
      expect(assigns(:incenses).size).to_not be_nil
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
end
