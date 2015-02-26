require "rails_helper"

describe UsersController do
  describe "GET show" do
    let(:user) do
      User.create(
        uid: 1,
        nickname: "yoshiori",
        name: "Yoshiori SHOJI",
        image: "http://example.com/",
      )
    end

    it "assigns @user" do
      get :show, nickname: user.nickname
      expect(assigns(:user)).to eq user
    end

    it "renders the show template" do
      get :show, nickname: user.nickname
      expect(response).to render_template("show")
    end
  end
end
