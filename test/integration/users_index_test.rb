require 'test_helper'
class UsersIndexTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:tanakataro)
    @non_admin = users(:satouhanako)
  end
  
  test "index including all users" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    users = User.all
    users.each do |user|
      assert_select "a[href=?]", user_path(user), text: user.nickname
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'ユーザーを削除'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end
  
  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'ユーザーを削除', count: 0
  end
    
  test "should not display follow-btn when not login in user index" do
    get users_path
    assert_select 'form.edit_relationship', count: 0
    assert_select 'form.new_relationship', count: 0
  end
  
  test "should display follow-btn when login in user index" do
    user = users(:tanakataro)
    log_in_as(user)
    get users_path
    assert_select 'form.edit_relationship'
    assert_select 'form.new_relationship'
  end
end
