class WelcomeController < ApplicationController
  # need to get the user data and give the option of getting info from fitbit
  rescue_from FitbitLogBadRefreshToken, with: :handle_bad_fitbit_login

  def index
    #  @water_log = FitbitLog.new(current_user).get_water_log_for_date(Time.new(2017, 1, 12))
    # @food_log = FitbitLog.new(current_user).get_food_log_for_date(Time.new(2017, 1, 12))
  end

  private def handle_bad_fitbit_login
    redirect_to root_path
  end
end
