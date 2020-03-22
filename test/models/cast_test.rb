require 'test_helper'

class CastTest < ActiveSupport::TestCase
  def setup 
    @cast = casts(:casttest1)
  end
  
  test "name should be prisent" do
    @cast.name = " "
    assert_not @cast.valid?
  end
  
  test "name should be unique" do
    duplicate_cast = @cast.dup
    duplicate_cast.name = "director1"
    @cast.save
    assert_not duplicate_cast.valid?
  end
end
