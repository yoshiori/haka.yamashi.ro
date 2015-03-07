Rails.application.routes.draw do
  concern :paginatable do
    get "(page/:page)", action: :index, on: :collection, as: ""
  end

  root to: "root#index"

  # omniauth
  get "/auth/:provider/callback", to: "sessions#create"

  delete "/signout" => "sessions#destroy", as: :signout

  resources :incenses, only: [:create, :index], concerns: :paginatable

  # get "/@:nickname" => "users#show", as: :user
  get "/@:nickname/(page/:page)" => "users#show", as: :user
end
