require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:tanakataro)
    @other_user = users(:satouhanako)
  end
  
  test "should redirect new when not activated" do
    get signup_path
    assert_redirected_to send_activation_email_path
  end
  
  test "should redirect root when form for get request to confirm" do
    get confirm_path
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect edit_prof when not login" do
    get "/users/#{@user.id}/edit_user_prof"
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect edit_account when not login" do
    get "/users/#{@user.id}/edit_user_account"
    assert_redirected_to login_url
  end
  
  test "should redirect edit_password when not login" do
    get "/users/#{@user.id}/edit_user_password"
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect update_prof when not login" do
    patch "/users/#{@user.id}/edit_user_prof", params: { user: { nickname:  @user.nickname,
                                                         profile: @user.profile}}
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect update_password when not login" do
    patch "/users/#{@user.id}/edit_user_password",params: { user: { password:  "password",
                                                         password_confirmation: "password"}}
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect edit_prof when logged in as wrong user" do
    log_in_as(@other_user)
    get "/users/#{@user.id}/edit_user_prof"
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect edit_account when logged in as wrong user" do
    log_in_as(@other_user)
    get "/users/#{@user.id}/edit_user_account"
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect edit_password when logged in as wrong user" do
    log_in_as(@other_user)
    get "/users/#{@user.id}/edit_user_password"
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect update_prof when logged in as wrong user" do
    log_in_as(@other_user)
    patch "/users/#{@user.id}/edit_user_prof", params: { user: { nickname:  @user.nickname,
                                                         profile: @user.profile}}
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect update_password when logged in as wrong user" do
    log_in_as(@other_user)
    patch "/users/#{@user.id}/edit_user_password",params: { user: { password:  "password",
                                                         password_confirmation: "password"}}
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch "/users/#{@user.id}/edit_user_prof", params: { user: { nickname:  @user.nickname,
                                                         profile: @user.profile,
                                                         admin: true}}
    assert_not @other_user.reload.admin?
  end
  
  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end
  
  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end
  
  test "should not display follow-btn when not login in user show" do
    get user_path(@user)
    assert_select 'form.edit_relationship', count: 0
    assert_select 'form.new_relationship', count: 0
  end
  
  test "should display follow-btn when login in user show" do
    log_in_as(@user)
    get user_path(@other_user)
    assert_select 'form.new_relationship'
  end

end
