require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup 
    @user = User.new(name:"Example User", email:"user@example.com",
                     password:"hogehoge", password_confirmation:"hogehoge",
                     nickname:"nickname", agreement:true)
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be prisent" do
    @user.name = "  "
    assert_not @user.valid?
  end
  
  test "email should be prisent" do
    @user.email = "  "
    assert_not @user.valid?
  end
  
  test "nickname should be prisent" do
    @user.nickname = "  "
    assert_not @user.valid?
  end
  
  test "password should be prisent" do
    @user.password = @user.password_confirmation = " " * 5
    assert_not @user.valid?
  end

  
  test "name should not be too long" do
    @user.name = "a"*16
    assert_not @user.valid?
  end
  
  test "email should not be too long" do
    @user.email = "a"*244 + "@example.com"
    assert_not @user.valid?
  end
  
  test "profile should not be too long" do
    @user.profile = "a"*1201
    assert_not @user.valid?
  end
  
  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a"* 4
    assert_not @user.valid?
  end
  
  test "nickname should not be too long" do
    @user.nickname = "a"*16
    assert_not @user.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert_not @user.valid?, "#{valid_address.inspect} should be invalid"
    end
  end
  
  test "password validation should accept valid password" do
    valid_passwords = %W[aaa\saa a-aaaa あああああ　１２３４５ aaaaa\n]
    valid_passwords.each do |valid_password|
      @user.password = @user.password_confirmation = valid_password
      assert_not @user.valid?, "#{valid_password.inspect} should be invalid"
    end
  end
  
  test "name should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = "user2@example.com"
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.name = "Example User2"
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "UsEr@ExamPlE.Com"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  test "agreement should be true" do
    @user.agreement = false
    @user.save
    assert_not @user.valid?
  end
  
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end
  
  
end
