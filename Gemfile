source 'http://rubygems.org'

gem 'rails', '3.0.7'

group :development, :test do
  gem 'sqlite3'
  gem 'itslog'
  # Use mongrel because webrick has trouble with the long openid urls
  gem 'mongrel', '1.2.0.pre2'
  # For tests
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'capybara', :git => 'git://github.com/jnicklas/capybara.git', :ref => '97af9bd1c66fe54d1cb8c65b88518f1695331f5a'
  gem 'database_cleaner'
  gem 'launchy'
end

group :development do
  gem 'nifty-generators'
  gem 'ruby-debug19'
  # Guards
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'guard-jammit', :git => 'git://github.com/Heigh-Tech/guard-jammit.git'
  # Linux notifications from Guard
  gem 'rb-inotify'
  gem 'libnotify'
end

gem 'rmagick', :require => 'RMagick'
gem 'omniauth'
gem 'hoptoad_notifier'
gem 'pdfkit'
gem 'json'
gem 'rack-rewrite'
gem 'signet', :require => 'signet/oauth_1/client'
gem 'devise' # Devise is needed for RailsAdmin
gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'
gem 'recaptcha', :require => 'recaptcha/rails'
gem 'jammit'
gem 'meta_where'
gem 'sitemap_generator'
gem 'memcache-client'
gem 'will_paginate', '3.0.pre2'
