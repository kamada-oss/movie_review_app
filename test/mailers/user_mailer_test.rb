require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user = users(:tanakataro)
    user.activation_token = sprintf("%.4d", rand(10000))
    mail = UserMailer.account_activation(user)
    #assert_equal "Kamarksご本人さま確認メール：認証番号のお知らせ", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@kamarks.com"], mail.from
    assert_match user.activation_token, mail.body.encoded
    assert_match user.email, mail.body.encoded
  end

  test "password_reset" do
    
  end

end
