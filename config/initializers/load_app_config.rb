# Load the application's configuration from YAML
raw_config = File.read("#{Rails.root}/config/app_config.yml")
APP_CONFIG = YAML.load(raw_config).symbolize_keys
