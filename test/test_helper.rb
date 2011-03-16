ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

unless defined?(Test::Unit::AssertionFailedError)
  class Test::Unit::AssertionFailedError < ActiveSupport::TestCase::Assertion
  end
end

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
  
  def signin
    session[:user_id] = Factory(:user).id
  end
  
  def setup_selenium
    @verification_errors = []
    @selenium = Selenium::Client::Driver.new \
      :host => "localhost",
      :port => 4444,
      :browser => "*chrome",
      :url => "http://localhost:3001/",
      :timeout_in_second => 6
      
    @selenium.start_new_browser_session
  end
  
  def teardown_selenium
    @selenium.close_current_browser_session
    assert_equal [], @verification_errors
  end
end
