require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end
  
  test "should not send email with wrong email" do
    get send_activation_email_path
    post send_activation_email_path,params:{user:{email: " "}}
    assert_equal 0, ActionMailer::Base.deliveries.size
    assert_template 'users/enter_activaton_email'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end
  
  test "should send email with correct email" do
    post send_activation_email_path,params:{user:{email: "test@test.com"}}
    assert_equal 1, ActionMailer::Base.deliveries.size
    follow_redirect!
    assert_template 'users/enter_authcode'
  end
  
  test "should not authenticate with wrong authcode" do
    get authenticate_authcode_path
    user = User.new
    user.email = "test@test.com"
    user.activation_digest = User.digest("1234")
    post authenticate_authcode_path, params:{authenticate:{authcode: "1235"},
                                             email: user.email, activation_digest: user.activation_digest}
    assert_template 'users/enter_authcode'
    assert_not flash.empty?
    assert_select 'a', text: 'メンバー登録のトップに戻る', count: 1
  end
  
  test "should authenticate with correct authcode" do
    user = User.new
    user.email = "test@test.com"
    user.activation_digest = User.digest("1234")
    post authenticate_authcode_path, params:{authenticate:{authcode: "1234"},
                                             email: user.email, activation_digest: user.activation_digest}
    follow_redirect!
    assert_template 'users/new'
    assert flash.empty?
  end
  
  test "should show signup information in confirm" do
    post confirm_path,params:{user:{name:"",email:"user@invalid", password:"hoge", password_confirmation: "geho",
                              nickname:"", agreement:false}}
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
    post confirm_path,params:{user:{name:"Example User", email:"example@example.com",password:"Example",
                             password_confirmation:"Example", nickname:"Example", agreement:true, activated:true}}
    assert_template 'users/confirm'
    assert flash.empty?
  end
  
  test "invalid signup information" do 
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path,params:{user:{name:"",email:"user@invalid", password:"hoge", password_confirmation: "geho",
                               nickname:"", agreement:false}}
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end
  
  test "valid signup information with account_activation" do
    assert_difference 'User.count', 1 do
      post signup_path,params:{user:{name:"Example User", email:"example@example.com",password:"Example",
                              password_confirmation:"Example", nickname:"Example", agreement:true, activated:true}}
      end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?
  end
end
    
