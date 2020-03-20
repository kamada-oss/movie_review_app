require 'test_helper'

class DirectorsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get directors_show_url
    assert_response :success
  end

end
