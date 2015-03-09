class YmsrAPI < Grape::API
  version "v1", using: :path
  format :json
  formatter :json, Grape::Formatter::Rabl
  prefix :api

  resource :incenses do
    params do
      optional :page, type: Integer, desc: "Page Num"
    end

    desc "Return a incenses timeline."
    get rabl: "incenses/index" do
      @incenses = Incense.recent.includes(:user).page(params[:page])
    end
  end

  resource :users do
    params do
      optional :page, type: Integer, desc: "Page Num"
    end

    desc "Return a user detail."
    get ":nickname", rabl: "users/show" do
      @user = User.find_by(nickname: params[:nickname])
    end

    desc "Return a user's incenses."
    get ":nickname/incenses", rabl: "incenses/index" do
      @incenses = User.find_by(nickname: params[:nickname])
                  .incenses.recent.includes(:user)
                  .page(params[:page])
    end
  end
end
