# Make sure the necessary configuration files are present

if !File.exists?('config/app_config.yml')
  require 'fileutils'
  FileUtils.cp('../app_config.yml', 'config/')
end

if !File.exists?('config/initializers/secret_token.rb')
  require 'fileutils'
  FileUtils.cp('../secret_token.rb', 'config/initializers/')
end

unless File.exists?('config/app_config.yml') && File.exists?('config/initializers/secret_token.rb')
  # Remind the user to create config files
  raise 'Sketch Lab configuration files missing!'
end
