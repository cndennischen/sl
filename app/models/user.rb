class User < ActiveRecord::Base
  has_many :sketches, :dependent => :destroy

  validates_presence_of :provider, :uid, :email
  validates_uniqueness_of :uid, :email

  # Creates a user with OmniAuth
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
      user.email = auth["user_info"]["email"]
    end
  end

  # Refreshes the user's plan by uncaching it, causing it to be recalculated
  # the next time it's needed.
  def refresh_plan!
    Rails.cache.delete(plan_key)
  end

  # Returns the key that is be used to cache the user's plan
  def plan_key
    "#{cache_key}-plan"
  end

  # Returns true if the user is an admin
  def admin?
    # The user is considered an admin if his email address is admin@sketchlabhq.com
    # Fair assumption? :)
    email == 'admin@sketchlabhq.com'
  end

  # Returns the user's plan
  def plan
    # Check if the user is an admin
    if admin?
      # The admin is always considered a premium user
      return 'premium'
    end
    # Cache the plan with Memcached
    Rails.cache.fetch(plan_key, :expires_in => 3.minutes) { access_level }
  end

  private

  # The behind the scenes logic to get the users plan
  def access_level
    if kind.blank?
      # Send a request to the Google Chrome Licensing API to check the user's status
      appId  = 'delppejinhhpcmimgfchjkbkpanhjkdj'
      userId = CGI::escape(uid)
      client = Signet::OAuth1::Client.new(
        :client_credential_key => 'anonymous',
        :client_credential_secret => 'anonymous',
        :token_credential_key => APP_CONFIG[:token_credential_key],
        :token_credential_secret => APP_CONFIG[:token_credential_secret]
      )
      response = client.fetch_protected_resource(
        :uri => "https://www.googleapis.com/chromewebstore/v1/licenses/#{appId}/#{userId}"
      )
      # Get the accessLevel from the JSON response
      if JSON.parse(response[2][0])["accessLevel"] == "FULL"
        'premium'
      else
        'basic'
      end
    else
      kind
    end
  end

end
