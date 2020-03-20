require 'test_helper'

class MovieDirectorTest < ActiveSupport::TestCase
  def setup
    @movie = movies(:movietest1)
    @director = directors(:directortest1)
    @movie_director = @movie.movie_directors.build(director_id: @director.id)
  end
  test "movie_id should be prisent" do
    @movie_director.movie_id = " "
    assert_not @movie_director.valid?
  end
  
  test "director_id should be prisent" do
    @movie_director.director_id = " "
    assert_not @movie_director.valid?
  end
end
