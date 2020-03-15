require 'test_helper'

class WriterTest < ActiveSupport::TestCase
  def setup 
    @writer = writers(:writertest1)
  end
  
  test "name should be prisent" do
    @writer.name = " "
    assert_not @writer.valid?
  end
  
  test "name should be unique" do
    duplicate_writer = @writer.dup
    duplicate_writer.name = "writer1"
    @writer.save
    assert_not duplicate_writer.valid?
  end
end
