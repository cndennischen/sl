ActionMailer::Base.smtp_settings = {
  :address              => MAIL_CONFIG[:address],
  :port                 => MAIL_CONFIG[:port],
  :domain               => MAIL_CONFIG[:domain],
  :user_name            => MAIL_CONFIG[:user_name],
  :password             => MAIL_CONFIG[:password],
  :authentication       => MAIL_CONFIG[:authentication],
  :enable_starttls_auto => MAIL_CONFIG[:enable_starttls_auto]
}

ActionMailer::Base.default_url_options[:host] = APP_CONFIG[:domain]
Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?