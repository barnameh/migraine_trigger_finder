Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'welcome#index'

  # Provides a button to launch auth
  root "fitbit_auth#index"

  # fitbit oauth
  get "/auth/fitbit", controller: "fitbit_auth", action: "make_request"
  get "/auth/fitbit/callback", controller: "fitbit_auth", action: "get_response"

  resources :welcome, only: [:index]
end
