require 'test_helper'

class DirectorTest < ActiveSupport::TestCase
  def setup 
    @director = directors(:directortest1)
  end
  
  test "name should be prisent" do
    @director.name = " "
    assert_not @director.valid?
  end
  
  test "name should be unique" do
    duplicate_director = @director.dup
    duplicate_director.name = "director1"
    @director.save
    assert_not duplicate_director.valid?
  end
end
