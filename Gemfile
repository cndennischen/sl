source 'http://rubygems.org'

gem 'rails'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem 'nifty-generators'
  # use mongrel because webrick has trouble with the long openid urls
  gem 'mongrel', '1.2.0.pre2'
  gem "ruby-debug19"
  # use sqlite for development and testing, but MySQL for production
  gem 'sqlite3-ruby', :require => 'sqlite3'
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
gem 'jammit', :require => 'jammit'
