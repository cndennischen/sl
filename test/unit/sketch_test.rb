require 'test_helper'

class SketchTest < ActiveSupport::TestCase
  test "create sketch with valid data" do
    s = Factory.build(:sketch)
    assert s.save
  end
  
  test "create sketch without name" do
    s = Factory.build(:sketch, :name => nil)
    assert !s.save
  end
  
  test "create sketch without content" do
    s = Factory.build(:sketch, :content => nil)
    assert s.save
  end
  
  test "create sketch without user_id" do
    s = Factory.build(:sketch, :user_id => nil)
    assert !s.save
  end
end
