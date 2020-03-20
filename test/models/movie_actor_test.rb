require 'test_helper'

class MovieActorTest < ActiveSupport::TestCase
  def setup
    @movie = movies(:movietest1)
    @actor = actors(:actortest1)
    @movie_actor = @movie.movie_actors.build(actor_id: @actor.id)
  end
  test "movie_id should be prisent" do
    @movie_actor.movie_id = " "
    assert_not @movie_actor.valid?
  end
  
  test "actor_id should be prisent" do
    @movie_actor.actor_id = " "
    assert_not @movie_actor.valid?
  end
end
