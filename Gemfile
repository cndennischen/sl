source 'http://rubygems.org'

gem 'rack', '1.2.1'
gem 'rails', '3.0.7'

gem 'sqlite3', :require => 'sqlite3'

group :development, :test do
  # use mongrel because webrick has trouble with the long openid urls
  gem 'mongrel', '1.2.0.pre2'
  # for tests
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'capybara', :git => 'git://github.com/jnicklas/capybara.git', :ref => '97af9bd1c66fe54d1cb8c65b88518f1695331f5a'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'autotest'
  gem 'autotest-rails'
end

group :development do
  gem 'nifty-generators'
  gem 'ruby-debug19'
end

gem 'rmagick', :require => 'RMagick'
gem 'omniauth'
gem 'hoptoad_notifier'
gem 'newrelic_rpm'
gem 'pdfkit'
gem 'json'
gem 'rack-rewrite'
gem 'signet', :require => 'signet/oauth_1/client'
gem 'devise' # Devise is needed for RailsAdmin
gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'
gem 'recaptcha', :require => 'recaptcha/rails'
gem 'jammit', :require => 'jammit'
gem 'meta_where'
gem 'sitemap_generator'
gem 'memcache-client'
