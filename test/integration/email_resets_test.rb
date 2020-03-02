require 'test_helper'

class EmailResetsTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:tanakataro)
  end
  
  test "email resets" do
    log_in_as(@user)
    get "/email_resets/#{@user.id}/new"
    assert flash.empty?
    assert_template 'email_resets/new'
    # メールアドレスが無効
    user = assigns(:user)
    post "/email_resets/#{user.id}/create", params: {user: { email: " "}}
    assert_template 'email_resets/new'
    post "/email_resets/#{user.id}/create", params: {user: { email: user.email}}
    assert_template 'email_resets/new'
    # メールアドレスが有効
    post "/email_resets/#{user.id}/create", params: { user: {email: user.email + "a" }}
    assert_not_equal user.reset_digest, user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_redirected_to edit_email_reset_path(id: user.id, email: user.email + "a")
    # トークンが無効
    user.reset_digest = User.digest("1234")
    post "/email_resets/#{user.id}/update", params: { email: user.email + "a", email_reset: { reset_token: "4321"}}
    assert_template 'email_resets/edit'
    # トークンが有効
    #user.email = "hoge@hoge.com"
    #user.reset_digest = User.digest("1234")
    #post "/email_resets/#{user.id}/update", params: { email: user.email, email_reset: { reset_token: "1234"}}
    #follow_redirect!
    #assert_template 'email_resets/new'
  end
  
  
end
