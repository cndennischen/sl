class User < ActiveRecord::Base
  has_many :sketches, :dependent => :destroy

  validates_presence_of :provider, :uid, :name, :email
  validates_uniqueness_of :uid, :email

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
      user.email = auth["user_info"]["email"]
    end
  end

  def plan
    # cache the plan
    @plan ||= access_level
  end

  private

  def access_level
    if kind.blank?
      # send a request to the Google Chrome Licensing API to check the user's status
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
      # get the accessLevel from the json response
      if JSON.parse(response[2][0])["accessLevel"] == "FULL"
        return 'paid'
      else
        return 'free'
      end
    else
      return kind
    end
  end

end
