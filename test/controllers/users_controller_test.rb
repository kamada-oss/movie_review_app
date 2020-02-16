require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:tanakataro)
    @other_user = users(:satouhanako)
  end
  
  test "should appear edit-btn when correct user" do
    log_in_as(@user)
    get "/users/#{@user.id}"
    assert_select 'a[href=?]', "/users/#{@user.id}/edit_user_prof",  text: 'プロフィール編集'
    assert_select 'a', text: 'フォロー', count: 0
  end
  
  test "should get new" do
    get signup_path
    assert_response :success
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
  
  test "should redirect edit_email when not login" do
    get "/users/#{@user.id}/edit_user_email"
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
  
  test "should redirect edit_email when logged in as wrong user" do
    log_in_as(@other_user)
    get "/users/#{@user.id}/edit_user_email"
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
end
