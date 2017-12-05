require 'test_helper'

class AccountMailerTest < ActionMailer::TestCase
  test "registrationConfirmation" do
    mail = AccountMailer.registrationConfirmation
    assert_equal "Registrationconfirmation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
