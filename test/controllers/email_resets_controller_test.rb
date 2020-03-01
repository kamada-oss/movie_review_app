require 'test_helper'

class EmailResetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:tanakataro)
    @other_user = users(:satouhanako)
  end
  
  test "should redirect edit_email when logged in as wrong user" do
    log_in_as(@other_user)
    get "/email_resets/#{@user.id}/new"
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect edit_email when not login" do
    get "/email_resets/#{@user.id}/new"
    assert_not flash.empty?
    assert_redirected_to login_url
  end

end
