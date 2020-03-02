require 'test_helper'

class EmailResetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:tanakataro)
    @other_user = users(:satouhanako)
  end
  
  test "should redirect root when logged in as wrong user to new" do
    log_in_as(@other_user)
    get "/email_resets/#{@user.id}/new"
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect root when not login to new" do
    get "/email_resets/#{@user.id}/new"
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect root when logged in as wrong user to create" do
    log_in_as(@other_user)
    post "/email_resets/#{@user.id}/create", params: { user: { email: @user.email}}
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect edit_email when not login to create" do
    post "/email_resets/#{@user.id}/create", params: { user: { email: @user.email}}
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect root when logged in as wrong user to edit" do
    log_in_as(@other_user)
    get "/email_resets/#{@user.id}/edit", params: { user: { email: @user.email}}
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect edit_email when not login to edit" do
    get "/email_resets/#{@user.id}/edit", params: { user: { email: @user.email}}
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect root when logged in as wrong user to update" do
    log_in_as(@other_user)
    @user.reset_token = "1234"
    post "/email_resets/#{@user.id}/update", params: { emial_reset: { reset_token: "1234"}}
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect edit_email when not login to update" do
    @user.reset_token = "1234"
    post "/email_resets/#{@user.id}/update", params: { emial_reset: { reset_token: "1234"}}
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  

end
