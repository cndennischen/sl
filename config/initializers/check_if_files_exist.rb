# Make sure the necessary configuration files are present
unless File.exists?('config/app_config.yml') && File.exists?('config/initializers/secret_token.rb')
  # Remind the user to create config files
  raise 'Sketch Lab configuration files missing!'
end
