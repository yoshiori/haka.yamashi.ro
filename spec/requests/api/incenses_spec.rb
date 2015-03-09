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

  describe "GET /api/v1/incenses" do
    before do
      user.fire_incense
    end

    context "page 1" do
      it "return incenses json" do
        get "/api/v1/incenses"
        expect(response.body).to be_json(
          incenses: [
            {
              created_at: /^\d\d\d\d-\d\d-\d\dT\d\d:\d\d:\d\d\.\d\d\d\+\d\d:\d\d/,
              user: {
                name: "Yoshiori SHOJI",
                nickname: "yoshiori",
                image: "http://example.com/",
                created_at: /^\d\d\d\d-\d\d-\d\dT\d\d:\d\d:\d\d\.\d\d\d\+\d\d:\d\d/,
              },
            },
          ],
          total_count: 1,
          num_pages: 1,
          current_page: 1,
          next_page: nil,
          prev_page: nil,
        )
      end
    end

    context "page 2" do
      it "no incenses" do
        get "/api/v1/incenses?page=2"
        expect(response.body).to be_json(
          total_count: 1,
          num_pages: 1,
          current_page: 2,
          next_page: nil,
          prev_page: 1,
        )
      end
    end
  end
end
