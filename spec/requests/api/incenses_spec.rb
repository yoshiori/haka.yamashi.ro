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

  describe "GET /api/v1/incenses" do
    before do
      user.fire_incense
      user2.fire_incense
    end

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
          total_pages: 1,
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
          total_pages: 1,
          current_page: 2,
          next_page: nil,
          prev_page: 1,
        )
      end
    end
  end

  describe "POST /api/v1/incenses" do
    context "valid token" do
      let(:token) { user.create_token.token }

      context "when once a day" do
        it "create new incense" do
          expect { post "/api/v1/incenses", token: token }.to change {
            Incense.count
          }.from(0).to(1)
          expect(response.status).to be 201
          expect(Incense.all.last.source).to eq "api"
        end
      end

      context "when twice a day" do
        before do
          Timecop.travel(Time.local(2012, 12, 3, 12, 15, 0))
          user.incenses.create
        end

        after do
          Timecop.return
        end

        it "not create incense" do
          expect { post "/api/v1/incenses", token: token }.to_not change {
            Incense.count
          }
          expect(response.status).to be 409
        end
      end
    end

    context "invalid token" do
      let(:token) { "invalid_#{user.create_token.token}" }

      it "not create incense" do
        expect { post "/api/v1/incenses", token: token }.to_not change {
          Incense.count
        }
        expect(response.status).to be 401
      end
    end
  end
end
