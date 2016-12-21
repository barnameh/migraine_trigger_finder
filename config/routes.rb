Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'welcome#index'

  # Provides a button to launch auth
    root "fitbit_auth#index"

  # fitbit oauth
  post "/auth/fitbit" => "fitbit_auth#make_request"
  get "/auth/fitbit/callback" => "fitbit_auth#get_response"
end
