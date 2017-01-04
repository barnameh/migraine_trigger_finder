require "test_helper"

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:fitbit] = OmniAuth::AuthHash.new(
    provider:"fitbit",
      uid: "5BZP3W",
      info: {
        name: "rajab",
        full_name: "rajab",
        display_name: "rajab",
        nickname: nil,
        gender: "MALE",
        about_me: nil,
        city: nil,
        state: nil,
        country: nil,
        dob: "1995-03-21",
        member_since: "2017-01-04",
        locale: "en_US",
        timezone: "America/Los_Angeles"
      },
      credentials: {
        token: "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI1QlpQM1ciLCJhdWQiOiIyMjg2WEgiLCJpc3MiOiJGaXRiaXQiLCJ0eXAiOiJhY2Nlc3NfdG9rZW4iLCJzY29wZXMiOiJyYWN0IHJ3ZWkgcnBybyBybnV0IHJzbGUiLCJleHAiOjE0ODM1ODM5NjAsImlhdCI6MTQ4MzU1NTE2MH0.nRRDHw94CYWvx8qk_3irUVGH3B_7u5gB_f4Mv00kOWY",
        refresh_token: "c03130b26c261f8d9be3b42f7a842304ed7f0d57b2e7aa47ef530b802e09b0a5",
        expires_at: 1483583960,
        expires: true
      },
      extra: {
        raw_info: {
          user: {
            age: 21,
            avatar: "https://static0.fitbit.com/images/profile/defaultProfile_100_male.gif",
            avatar150: "https://static0.fitbit.com/images/profile/defaultProfile_150_male.gif",
            averageDailySteps: 0,
            clockTimeDisplayFormat: "12hour",
            corporate: false,
            corporateAdmin: false,
            dateOfBirth: "1995-03-21",
            displayName: "rajab",
            displayNameSetting: "name",
            distanceUnit: "en_US",
            encodedId: "5BZP3W",
            features: {
              exerciseGoal: true
            },
            foodsLocale: "en_US",
            fullName: "rajab",
            gender: "MALE",
            glucoseUnit: "en_US",
            height: 185.5,
            heightUnit: "en_US",
            locale: "en_US",
            memberSince: "2017-01-04",
            mfaEnabled: false,
            offsetFromUTCMillis: -28800000,
            startDayOfWeek: "SUNDAY",
            strideLengthRunning: 127.80000000000001,
            strideLengthRunningType: "default",
            strideLengthWalking: 77,
            strideLengthWalkingType: "default",
            swimUnit: "en_US",
            timezone: "America/Los_Angeles",
            topBadges: [],
            waterUnit: "en_US",
            waterUnitName: "fl oz",
            weight: 72.5,
            weightUnit: "en_US"
          }
        }
      }
    )
  end

  def sign_in_user
    get "/auth/fitbit"
    follow_redirect!
  end

  test "can get index page" do
    sign_in_user
    get welcome_index_path
  end
end
