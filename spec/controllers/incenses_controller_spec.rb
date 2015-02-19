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
      context "when twice a day" do
        context "when same user" do
          before do
            Timecop.travel(Time.local(2012, 12, 3, 12, 15, 0))
            user.incenses.create
          end

          after do
            Timecop.return
          end

          it "not create incense" do
            expect { post :create }.to_not change { Incense.count }
            expect(response.status).to be 409
          end
        end
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
