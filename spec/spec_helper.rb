ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # dont' use transactions, because selenium doesn't have access to them
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  # because we're not using transactions, clear the database after each
  # test with DatabaseCleaner
  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

# set up OmniAuth test mode
OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:google] = {
  'provider' => 'google',
  'uid' => 'test_uid',
  'user_info' => {
    'name' => 'test_name',
    'email' => 'test_email@example.com'
  }
}

def signin
  visit '/auth/google'
end

def requires_auth(path, use_post = false)
  if use_post
    # use plain rspec because capybara doesn't support sending post requests
    post path
    response.should redirect_to('/signin')
    flash[:notice].should_not be_nil
  else
    visit path
    current_path.should == '/signin'
    page.should have_selector('#flash_notice')
  end  
end
