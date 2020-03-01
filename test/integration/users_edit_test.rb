require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:tanakataro)
  end
  
  test "unsuccessful edit prof" do
    log_in_as(@user)
    get "/users/#{@user.id}/edit_user_prof"
    assert_template "users/edit_prof"
    patch "/users/#{@user.id}/edit_user_prof", params: { user: { nickname:  "",
                                               profile: ""}}
    assert_template "users/edit_prof"
  end

  test "successful edit prof with friendly forwarding" do
    get "/users/#{@user.id}/edit_user_prof"
    log_in_as(@user)
    assert_redirected_to "/users/#{@user.id}/edit_user_prof"
    assert session[:forwarding_url].nil?
    nickname = "tanataro"
    profile = "こんにちは"
    patch "/users/#{@user.id}/edit_user_prof", params: { user: { nickname:  nickname,
                                               profile: profile}}
    assert_not flash.empty?
    assert_redirected_to action: 'edit_prof'
    @user.reload
    assert_equal nickname, @user.nickname
    assert_equal profile, @user.profile
  end
  
  test "unsuccessful edit password" do
    log_in_as(@user)
    get "/users/#{@user.id}/edit_user_account"
    assert_template "users/edit_account"
    patch "/users/#{@user.id}/edit_user_password", params: { user: { password:  "aaa",
                                               password_confirmation: "bbb"}}
    assert_template "users/edit_password"
  end
  
  test "successful edit password" do
    log_in_as(@user)
    get "/users/#{@user.id}/edit_user_password"
    password = "wordpass"
    patch "/users/#{@user.id}/edit_user_password", params: { user: { password:  password,
                                               password_confirmation: password}}
    assert_not flash.empty?
    #assert_redirected_to action: 'edit_password'
    @user.reload
    assert_not @user.authenticate(password).nil?
  end
  
end
