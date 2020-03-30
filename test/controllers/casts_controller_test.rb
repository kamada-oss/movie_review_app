require 'test_helper'

class CastsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @cast = casts(:casttest1)
  end
  
  test "should get show" do
    get cast_path(@cast)
    assert_response :success
  end
  
  test "should get show drama" do
    get "/casts/drama/#{@cast.id}"
    assert_response :success
  end
  
  test "should show movies" do
    get cast_path(@cast)
    movies = @cast.movies
    dramas = @cast.dramas
    movies.each do |movie|
      assert_select "a[href=?]", movie_path(movie)
    end
    dramas.each do |drama|
      assert_select "a[href=?]", drama_path(drama), count:0
    end
  end
  
  test "should show dramas" do
    get "/casts/drama/#{@cast.id}"
    movies = @cast.movies
    dramas = @cast.dramas
    movies.each do |movie|
      assert_select "a[href=?]", movie_path(movie), count:0
    end
    dramas.each do |drama|
      assert_select "a[href=?]", drama_path(drama)
    end
  end

end
