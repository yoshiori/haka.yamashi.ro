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

  describe "#fire_incense" do
    let(:user) do
      User.create(
        uid: 1,
        nickname: "yoshiori",
        name: "Yoshiori SHOJI",
        image: "http://example.com/",
      )
    end

    context "when once a day" do
      context "first fire" do
        it "create new incense" do
          expect { user.fire_incense }.to change { user.incenses.count }.from(0).to(1)
        end

        it "post tweet" do
          expect(YmsrLogger).to receive(:tweet)
            .with("yoshiori がお線香をあげました http://haka.yamashi.ro/ #ymsr").once
          user.fire_incense
        end
      end

      context "other day fire" do
        before do
          Timecop.travel(Time.local(2012, 12, 3, 12, 15, 0))
          user.fire_incense
          Timecop.travel(Time.local(2012, 12, 4, 0, 0, 0))
        end

        after do
          Timecop.return
        end

        it "create new incense" do
          expect { user.fire_incense }.to change { user.incenses.count }.from(1).to(2)
        end
      end
    end

    context "when twice a day" do
      before do
        Timecop.travel(Time.local(2012, 12, 3, 12, 15, 0))
        user.fire_incense
      end

      after do
        Timecop.return
      end

      subject do
        user.fire_incense
      end

      it "not create incense" do
        expect { subject }.to_not change { user.incenses.count }
        expect(subject).to be_nil
      end
    end
  end
end
