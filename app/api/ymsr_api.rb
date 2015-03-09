class YmsrAPI < Grape::API
  version "v1", using: :path
  format :json
  formatter :json, Grape::Formatter::Rabl
  prefix :api

  helpers do
    def token
      @token ||= Token.find_by(token: params[:token])
    end

    def authenticate!
      error!("401 Unauthorized", 401) unless token
    end
  end

  resource :incenses do
    desc "Return a incenses timeline."
    params do
      optional :page, type: Integer, desc: "Page Num"
    end
    get rabl: "incenses/index" do
      @incenses = Incense.recent.includes(:user).page(params[:page])
    end

    desc "create new incense."
    params do
      requires :token, type: String, desc: "API Token"
    end
    post do
      authenticate!
      error!("409 Conflict", 409) unless token.user.fire_incense(source: :api)
    end
  end

  resource :users do
    desc "Return a user detail."
    get ":nickname", rabl: "users/show" do
      @user = User.find_by(nickname: params[:nickname])
    end

    desc "Return a user's incenses."
    params do
      optional :page, type: Integer, desc: "Page Num"
    end
    get ":nickname/incenses", rabl: "incenses/index" do
      @incenses = User.find_by(nickname: params[:nickname])
                  .incenses.recent.includes(:user)
                  .page(params[:page])
    end
  end
end
