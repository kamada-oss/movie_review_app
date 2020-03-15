require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  def setup 
    @movie = movies(:movietest1)
  end
  
  test "title should be prisent" do
    @movie.title = " "
    assert_not @movie.valid?
  end
  
  test "title should be unique" do
    duplicate_movie = @movie.dup
    duplicate_movie.title = "test1"
    @movie.save
    assert_not duplicate_movie.valid?
  end
end
