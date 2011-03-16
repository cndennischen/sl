require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "create user with valid data" do
    u = Factory.build(:user)
    assert u.save
  end
  
  test "create user without name" do
    u = Factory.build(:user, :name => nil)
    assert !u.save
  end
  
  test "craete user without email" do
    u = Factory.build(:user, :email => nil)
    assert !u.save
  end
  
  test "create user without provider" do
    u = Factory.build(:user, :provider => nil)
    assert !u.save
  end
  
  test "craete user without uid" do
    u = Factory.build(:user, :uid => nil)
    assert !u.save
  end
  
  test "authentication" do
    setup_selenium
    
    @selenium.open "/signout"
    @selenium.click "link=Sign In / Sign Up"
    @selenium.wait_for_page_to_load "30000"
    @selenium.click "link=Sign in with your Google account"
    @selenium.wait_for_page_to_load "30000"
    begin
        assert @selenium.is_text_present("Signed In!") || @selenium.is_text_present("Signed Up!")
    rescue Test::Unit::AssertionFailedError
        @verification_errors << $!
    end
    begin
        assert @selenium.is_text_present("Your Sketches")
    rescue Test::Unit::AssertionFailedError
        @verification_errors << $!
    end
    
    @selenium.click "link=Sign Out"
    @selenium.wait_for_page_to_load
    begin
      assert @selenium.is_text_present("Signed Out!")
    rescue Test::Unit::AssertionFailedError
      @verification_errors << $!
    end
    
    teardown_selenium
  end
end
