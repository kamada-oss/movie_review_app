require 'test_helper'

class ActorTest < ActiveSupport::TestCase
  def setup 
    @actor = actors(:actortest1)
  end
  
  test "name should be prisent" do
    @actor.name = " "
    assert_not @actor.valid?
  end
  
  test "name should be unique" do
    duplicate_actor = @actor.dup
    duplicate_actor.name = "actor1"
    @actor.save
    assert_not duplicate_actor.valid?
  end
end
