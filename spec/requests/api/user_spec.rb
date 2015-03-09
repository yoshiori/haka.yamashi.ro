require "rails_helper"

describe YmsrAPI do
  let(:user) do
    User.create(
      uid: 1,
      nickname: "yoshiori",
      name: "Yoshiori SHOJI",
      image: "http://example.com/",
    )
  end

  describe "GET /api/v1/users/:nickname" do
    before do
      user.fire_incense
    end
    context "page 1" do
      it "return incenses json" do
        get "/api/v1/users/#{user.nickname}"
        expect(response.body).to be_json(
          user: {
            name: "Yoshiori SHOJI",
            nickname: "yoshiori",
            image: "http://example.com/",
            created_at: /^\d\d\d\d-\d\d-\d\dT\d\d:\d\d:\d\d\.\d\d\d\+\d\d:\d\d/,
          },
        )
      end
    end
  end
end
