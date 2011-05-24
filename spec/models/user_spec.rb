require 'spec_helper'

describe User do
  it 'creates user with valid data' do
    u = Factory.build(:user)
    assert u.save
  end

  it 'creates user without name' do
    u = Factory.build(:user, :name => nil)
    assert u.save
  end

  it 'does not craete user without email' do
    u = Factory.build(:user, :email => nil)
    assert !u.save
  end

  it 'does not create user without provider' do
    u = Factory.build(:user, :provider => nil)
    assert !u.save
  end

  it 'does not craete user without uid' do
    u = Factory.build(:user, :uid => nil)
    assert !u.save
  end
end
