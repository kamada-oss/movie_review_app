require 'test_helper'

class CastsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @cast = casts(:casttest1)
  end
  
  test "should get show" do
    get cast_path(@cast)
    assert_response :success
  end

end
