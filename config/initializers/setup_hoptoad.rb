# Use Hoptoad for reporting exceptions
HoptoadNotifier.configure do |config|
  config.api_key = APP_CONFIG[:hoptoad_api_key]
end
