require 'spec_helper'

describe Sketch do
  it 'creates sketch with valid data' do
    s = Factory.build(:sketch)
    assert s.save
  end

  it 'does not create sketch without name' do
    s = Factory.build(:sketch, :name => nil)
    assert !s.save
  end

  it 'does not create sketch without content' do
    s = Factory.build(:sketch, :content => nil)
    assert s.save
  end

  it 'does not create sketch without user_id' do
    s = Factory.build(:sketch, :user_id => nil)
    assert !s.save
  end

  it 'defaults "public" to false' do
    Factory.build(:sketch).public.should == false
  end
end
