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

  # Don't use transactions, because selenium doesn't have access to them
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  # Because we're not using transactions (see above), clear the database
  # after each test with DatabaseCleaner
  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

# Set up OmniAuth test mode
OmniAuth.config.test_mode = true # turn test mode on
# Set up a mock user to sign in with
OmniAuth.config.mock_auth[:google] = {
  'provider' => 'google',
  'uid' => 'test_uid',
  'user_info' => {
    'name' => 'test_name',
    'email' => 'test_email@example.com'
  }
}

# Sign in to Sketch Lab using OmniAuth
def signin
  # This will just sign in as the mock user created above
  visit '/auth/google'
end

# Create a new sketch
def create_sketch
  fill_in 'name', :with => 'Test Sketch'
  click_button 'New Sketch'
  Sketch.count.should == 1
end

# Verify that the specified path requires authentication
def requires_auth(path, use_post = false)
  if use_post
    # Use plain rspec because capybara doesn't support sending post requests
    post path
    response.should redirect_to('/signin')
    flash[:notice].should_not be_nil
  else
    visit path
    current_path.should == '/signin'
    # Check for the flash notice element on the page
    page.should have_selector('#flash_notice')
  end  
end
