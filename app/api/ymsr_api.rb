class YmsrAPI < Grape::API
  version "v1", using: :path
  format :json
  formatter :json, Grape::Formatter::Rabl
  prefix :api

  resource :incenses do
    params do
      optional :page, type: Integer, desc: "Page Num"
    end

    desc "Return a public timeline."
    get rabl: "incenses/index" do
      @incenses = Incense.recent.includes(:user).page(params[:page])
    end
  end
end
