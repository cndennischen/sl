require 'test_helper'

class NotificationsTest < ActionMailer::TestCase
  test "invalid_ipn" do
    mail = Notifications.invalid_ipn
    assert_equal "Invalid ipn", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
