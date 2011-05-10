# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
SketchLab::Application.initialize!

# Load certificate bundler
OpenID.fetcher.ca_file = "#{Rails.root}/config/ca-bundle.crt"

if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    # Only works with DalliStore
    Rails.cache.reset if forked
  end
end
