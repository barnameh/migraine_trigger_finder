require "base64"

class FitbitLog
  def initialize(user)
    @user = user
    @api_prefix = "https://api.fitbit.com/1/user/#{@user.fitbit_user_id}/"
  end

  def get_food_log_for_date(date)
    date_str = date.strftime("%Y-%m-%d")
    response = query_fitbit(@api_prefix + "foods/log/date/#{date_str}.json")
    food_names = []
    response["foods"].each {|food| food_names << food["loggedFood"]["name"]}
    food_names.uniq
  end

  def get_water_log_for_date(date)
    date_str = date.strftime("%Y-%m-%d")
    response = query_fitbit(@api_prefix + "foods/log/water/date/#{date_str}.json")
    @total_water = response["summary"]["water"].to_f
    # convert milliliter to ounce
    (@total_water/29.5735296875).ceil
  end

  def update_token
    Rails.logger.info "Beginning refresh token call"
    refresh_token_path = "https://api.fitbit.com/oauth2/token"
    client_base64 = Base64.encode64(ENV["FITBIT_CLIENT_KEY"] + ":" + ENV["FITBIT_CLIENT_SECRET"])
    headers = { "Authorization" => "Basic #{client_base64}",
                "Content-Type" => "application/x-www-form-urlencoded" }
    query = { "grant_type" => "refresh_token", "refresh_token" => @user.refresh_token }

    response = HTTParty.post(refresh_token_path, query: query, headers: headers)

    raise FitbitLogBadRefreshToken if response.code != 200

    # store new and refresed token
    @user.token = response["access_token"]
    @user.refresh_token = response["refresh_token"]
    @user.expires_at = Time.now + response["expires_in"]
    @user.save
  end

  def query_fitbit(path)
    headers = { Authorization: "Bearer #{@user.token}" }
    begin
      response = HTTParty.get(path, headers: headers)
      Rails.logger.debug "*" * 80
      Rails.logger.debug "Request to #{path} with #{headers}"
      Rails.logger.debug "*" * 80
      Rails.logger.debug response
      Rails.logger.debug "*" * 80
      case response.code
      when 200
        response
      when 401
        update_token
        response = HTTParty.get(path, headers: headers)
      when 400
        # bad request
        raise FitbitLogBadRequest
      when 403
        Rails.logger.info "403 error"
        # Forbidden
        raise FitbitLogForbiddenRequest
      when 404
        # Not Found
        raise FitbitLogResourceNotFound
      end
    rescue HTTParty::Error => error
      puts error.inspect
    end
  end
end
