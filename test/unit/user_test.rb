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
end
