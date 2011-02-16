raw_config = File.read("#{Rails.root}/config/mail_config.yml")
MAIL_CONFIG = YAML.load(raw_config).symbolize_keys
