require "rails_helper"

describe User do
  describe ".find_or_create_from_auth_hash" do
    let(:auth_hash) do
      {
        uid: "1",
        info: {
          nickname: "yoshiori",
          email: "yoshiori@gmail.com",
          name: "Yoshiori SHOJI",
          image: "https://avatars.githubusercontent.com/u/1?v=3",
          urls: {
            GitHub: "https://github.com/yoshiori",
            Blog: "http://yoshiori.github.com/",
          },
        },
      }.with_indifferent_access
    end

    subject { User.find_or_create_from_auth_hash(auth_hash) }

    context "user not found" do
      it "create user" do
        expect { subject }.to change { User.count }.from(0).to(1)
      end
    end

    context "user found" do
      before do
        User.create(uid: 1, nickname: "YOSHIORI", name: "yoshiori SHOJI")
      end

      it "return user" do
        expect { subject }.to_not change { User.count }
        expect(subject.nickname).to eq "YOSHIORI"
      end
    end
  end
end
