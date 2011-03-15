require 'test_helper'

class FaqTest < ActiveSupport::TestCase
  test "create faq with valid data" do
    f = Factory.build(:faq)
    assert f.save
  end
  
  test "create faq without question" do
    f = Factory.build(:faq, :question => nil)
    assert !f.save
  end
  
  test "create faq without answer" do
    f = Factory.build(:faq, :answer => nil)
    assert !f.save
  end
end
