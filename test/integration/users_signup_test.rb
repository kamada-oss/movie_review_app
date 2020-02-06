require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do 
    get signup_path
    assert_no_difference 'User.count' do
      post users_path,params:{user:{name:"",email:"user@invalid", password:"hoge", password_confirmation: "geho",
                                    nickname:"", agreement:false}}
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end
  
  test "valid signup information" do
    assert_difference 'User.count', 1 do
      post users_path,params:{user:{name:"Example User", email:"example@example.com",password:"Example",
                              password_confirmation:"Example", nickname:"Example", agreement:true}}
      end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?
  end
end
    
