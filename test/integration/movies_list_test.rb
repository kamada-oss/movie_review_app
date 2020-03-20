require 'test_helper'

class MoviesListTest < ActionDispatch::IntegrationTest
  test "should show now movies" do
    get movies_list_now_path
    movies = Movie.where(status: "公開中")
    movies.each do |movie|
      assert_select "a[href=?]", movie_path(movie)
      assert_select 'h5', text: movie.title
    end
    movies = Movie.where(status: "レンタル予定")
    movies.each do |movie|
      assert_select "a[href=?]", movie_path(movie), count: 0
      assert_select 'h5', text: movie.title, count: 0
    end
    movies = Movie.where(status: "レンタル")
    movies.each do |movie|
      assert_select "a[href=?]", movie_path(movie), count: 0
      assert_select 'h5', text: movie.title, count: 0
    end
    assert_select "a[href=?]", movies_list_now_path
    assert_select "a[href=?]", movies_list_rental_coming_path
    assert_select "a[href=?]", movies_list_rental_now_path
    #assert_select "a[href=?]", movies_list_recommended_path
  end
  
  test "should show rental coming movies" do
    get movies_list_rental_coming_path
    movies = Movie.where(status: "公開中")
    movies.each do |movie|
      assert_select "a[href=?]", movie_path(movie), count: 0
      assert_select 'h5', text: movie.title, count: 0
    end
    movies = Movie.where(status: "レンタル予定")
    movies.each do |movie|
      assert_select "a[href=?]", movie_path(movie)
      assert_select 'h5', text: movie.title
    end
    movies = Movie.where(status: "レンタル")
    movies.each do |movie|
      assert_select "a[href=?]", movie_path(movie), count: 0
      assert_select 'h5', text: movie.title, count: 0
    end
    assert_select "a[href=?]", movies_list_now_path
    assert_select "a[href=?]", movies_list_rental_coming_path
    assert_select "a[href=?]", movies_list_rental_now_path
    #assert_select "a[href=?]", movies_list_recommended_path
  end
  
  test "should show rental now movies" do
    get movies_list_rental_now_path
    movies = Movie.where(status: "公開中")
    movies.each do |movie|
      assert_select "a[href=?]", movie_path(movie), count: 0
      assert_select 'h5', text: movie.title, count: 0
    end
    movies = Movie.where(status: "レンタル予定")
    movies.each do |movie|
      assert_select "a[href=?]", movie_path(movie), count: 0
      assert_select 'h5', text: movie.title, count: 0
    end
    movies = Movie.where(status: "レンタル")
    movies.each do |movie|
      assert_select "a[href=?]", movie_path(movie)
      assert_select 'h5', text: movie.title
    end
    assert_select "a[href=?]", movies_list_now_path
    assert_select "a[href=?]", movies_list_rental_coming_path
    assert_select "a[href=?]", movies_list_rental_now_path
    #assert_select "a[href=?]", movies_list_recommended_path
  end
end
