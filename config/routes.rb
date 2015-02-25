Rails.application.routes.draw do
  root to: "root#index"

  # omniauth
  get "/auth/:provider/callback", to: "sessions#create"

  delete "/signout" => "sessions#destroy", :as => :signout

  resources :incenses, only: :create

  get "/@:id" => "users#show"
end
