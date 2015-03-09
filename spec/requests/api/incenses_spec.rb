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

  let(:user2) do
    User.create(
      uid: 2,
      nickname: "hoge",
      name: "foo",
      image: "http://example.com/",
    )
  end

  before do
    user.fire_incense
    user2.fire_incense
  end

  describe "GET /api/v1/incenses" do
    context "page 1" do
      it "return incenses json" do
        get "/api/v1/incenses"
        expect(response.body).to be_json(
          incenses: [
            {
              created_at: /^\d\d\d\d-\d\d-\d\dT\d\d:\d\d:\d\d\.\d\d\d\+\d\d:\d\d/,
              user: {
                name: "foo",
                nickname: "hoge",
                image: "http://example.com/",
                created_at: /^\d\d\d\d-\d\d-\d\dT\d\d:\d\d:\d\d\.\d\d\d\+\d\d:\d\d/,
              },
            },
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
          total_count: 2,
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
          total_count: 2,
          num_pages: 1,
          current_page: 2,
          next_page: nil,
          prev_page: 1,
        )
      end
    end
  end
end
