class FitbitAuthController < ApplicationController
  def index
    # if current_user
    #   redirect_to  welcome_index_path
    # end
  end

  def make_request
    # The request is made to Fitbit
  end

  def get_response
    # Callback from Fitbit Oauth
    fitbit_data = request.env['omniauth.auth']

    # User Information and User Access Credentials
    @user = set_user_info(fitbit_data)
    session["current_user_id"] = @user.id
    # needs to go to the welcome page
    redirect_to welcome_index_path
    # render json: fitbit_data
  end

  def destroy
    session.delete("current_user_id")
    redirect_to root_path
  end

private
  def set_user_info(fitbit_data)
    fitbit_user_id = fitbit_data["uid"]
    user = User.find_by(fitbit_user_id: fitbit_user_id)
    if user == nil
      user = User.new
      user.fitbit_user_id = fitbit_user_id
    end
    user.full_name = fitbit_data["info"]["full_name"]
    user.token = fitbit_data["credentials"]["token"]
    user.refresh_token = fitbit_data["credentials"]["refresh_token"]
    user.expires_at = fitbit_data["credentials"]["expires_at"]
    user.save
    user
  end
end
