module ApplicationHelper
  def access?
    # send a request to the chrome webstore licensing api
    appId = "delppejinhhpcmimgfchjkbkpanhjkdj"
    userId = CGI::escape(current_user.uid)
    client = Signet::OAuth1::Client.new(
      :client_credential_key => 'anonymous',
      :client_credential_secret => 'anonymous',
      :token_credential_key => OAUTH_CONFIG['token_credential_key'],
      :token_credential_secret => OAUTH_CONFIG['token_credential_key']
    )
    response = client.fetch_protected_resource(
      :uri => "https://www.googleapis.com/chromewebstore/v1/licenses/#{appId}/#{userId}"
    )
    # get the accessLevel from the json response
    JSON.parse(response[2][0])["result"]
  end

end
