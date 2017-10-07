require 'test_helper'

class NoticeMailerTest < ActionMailer::TestCase
  test "sendmail_test" do
    mail = NoticeMailer.sendmail_test
    assert_equal "Sendmail test", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
