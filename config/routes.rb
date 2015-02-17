Rails.application.routes.draw do
  root to: "root#index"

  # omniauth
  get "/auth/:provider/callback", to: "sessions#create"

  delete "/logout" => "sessions#destroy", :as => :logout
end
