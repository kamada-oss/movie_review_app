require 'test_helper'

class MovieWriterTest < ActiveSupport::TestCase
  def setup
    @movie = movies(:movietest1)
    @writer = writers(:writertest1)
    @movie_writer = @movie.movie_writers.build(writer_id: @writer.id)
  end
  
  test "movie_id should be prisent" do
    @movie_writer.movie_id = " "
    assert_not @movie_writer.valid?
  end
  
  test "writer_id should be prisent" do
    @movie_writer.writer_id = " "
    assert_not @movie_writer.valid?
  end
end
