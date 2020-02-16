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
end
