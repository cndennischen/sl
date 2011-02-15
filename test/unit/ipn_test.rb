require 'test_helper'

class IpnTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Ipn.new.valid?
  end
end
