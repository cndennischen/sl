ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
  def signin
    user_info = {:name => 'Test User', :email => 'test.user@example.com', :uid => 'testing', :procider => 'google'}    
    u = User.find_or_create_by_name_and_email_and_uid_and_provider(user_info)
    session[:user_id] = u.id
  end
end
