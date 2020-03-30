require 'test_helper'

class DramaTest < ActiveSupport::TestCase
  def setup 
    @drama = dramas(:dramatest1)
  end
  
  test "title should be prisent" do
    @drama.title = " "
    assert_not @drama.valid?
  end
  
  test "title should be unique" do
    duplicate_drama = @drama.dup
    duplicate_drama.title = "test1"
    @drama.save
    assert_not duplicate_drama.valid?
  end
end
