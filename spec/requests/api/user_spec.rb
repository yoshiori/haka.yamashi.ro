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

  let(:other_user) do
    User.create(
      uid: 2,
      nickname: "hoge",
      name: "foo",
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

    context "user not found" do
      it "return 404" do
        get "/api/v1/users/:nickname"
        expect(response.status).to be 404
      end
    end
  end

  describe "GET /api/v1/users/:nickname/incenses" do
    before do
      user.fire_incense
      other_user.fire_incense
    end
    context "found user" do
      it "return user's incenses" do
        get "/api/v1/users/#{user.nickname}/incenses"
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

    context "user not found" do
      it "return 404" do
        get "/api/v1/users/:nickname/incenses"
        expect(response.status).to be 404
      end
    end
  end
end
