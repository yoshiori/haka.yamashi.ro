require "rails_helper"

describe IncensesController do
  describe "#new" do
    context "when user signed in" do
      let(:user) do
        User.create(
          uid: 1,
          nickname: "yoshiori",
          name: "Yoshiori SHOJI",
          image: "http://example.com/",
        )
      end

      before do
        allow(controller).to receive(:current_user) { user }
      end

      it "create new incense" do
        expect { post :create }.to change { Incense.count }.from(0).to(1)
        expect(response.status).to be 201
      end
    end

    context "when user not sign in" do
      it "return 403" do
        expect { post :create }.to_not change { Incense.count }
        expect(response.status).to be 403
      end
    end
  end
end
