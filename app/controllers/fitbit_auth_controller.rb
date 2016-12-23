class FitbitAuthController < ApplicationController
  def make_request
    # The request is made to Fitbit
  end

  def get_response
    # Callback from Fitbit Oauth
    fitbit_data = request.env['omniauth.auth']

    # User Information and User Access Credentials
    user = set_user_info(fitbit_data)
    binding.pry
    # needs to go to the welcome page
    render json: fitbit_data
  end

private
  def set_user_info(fitbit_data)
    fitbit_user_id = fitbit_data["uid"]
    user = User.find_by(fitbit_user_id: fitbit_user_id)
    if user == nil
      user = User.new
    end
    user.fitbit_user_id = fitbit_user_id
    user.token = fitbit_data["credentials"]["token"]
    user.refresh_token = fitbit_data["credentials"]["refresh_token"]
    user.expires_at = fitbit_data["credentials"]["expires_at"]
    user.save
  end
end
