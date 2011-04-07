# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
SketchLab::Application.initialize!

# Load certificate bundler
OpenID.fetcher.ca_file = "#{Rails.root}/config/ca-bundle.crt"
