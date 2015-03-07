class YmsrAPI < Grape::API
  version "v1", using: :path
  format :json
  prefix :api

  resource :incenses do
    params do
      optional :page, type: Integer, desc: "Page Num"
    end

    desc "Return a public timeline."
    get :public_timeline do
      Incense.recent.includes(:user).page(params[:page])
    end
  end
end
