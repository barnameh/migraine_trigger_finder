Rails.application.routes.draw do
  # get 'episodes/index'
  #
  # get 'episodes/new'
  #
  # get 'episodes/create'
  #
  # get 'episodes/show'
  #
  # get 'episodes/update'
  #
  # get 'episodes/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'welcome#index'

  # Provides a button to launch auth
  # root "fitbit_auth#index"
  root 'welcome#index'

  # fitbit oauth
  get "/auth/fitbit", controller: "fitbit_auth", action: "make_request"
  delete "/auth/fitbit", controller: "fitbit_auth", action: "destroy"
  get "/auth/fitbit/callback", controller: "fitbit_auth", action: "get_response"

  resources :welcome, only: [:index]

  resources :episodes
end
