# Set up OmniAuth for user authentication
Rails.application.config.middleware.use OmniAuth::Builder do
  # Google OpenID
  provider :open_id, nil, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
end
