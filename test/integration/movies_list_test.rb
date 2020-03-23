require 'test_helper'

class MoviesListTest < ActionDispatch::IntegrationTest
  def setup
    @cast1 = casts(:casttest1)
    @cast2 = casts(:casttest2)
    @cast3 = casts(:casttest3)
    @cast4 = casts(:casttest4)
    @cast5 = casts(:casttest5)
    @cast6 = casts(:casttest6)
    @cast7 = casts(:casttest7)
    @cast8 = casts(:casttest8)
    @cast9 = casts(:casttest9)
  end
  
  test "should show now movies" do
    get movies_list_now_path
    movies = Movie.where(status: "公開中")
    movies.each do |movie|
      assert_select "a[href=?]", movie_path(movie)
      assert_select 'h5', text: movie.title
      assert_select "a[href=?]", "/movies/list/genre/#{movie.genre_translation}"
      assert_select "a[href=?]", cast_path(@cast1)
      assert_select "a[href=?]", cast_path(@cast2)
      assert_select "a[href=?]", cast_path(@cast3)
      assert_select "a[href=?]", cast_path(@cast4), count: 0
      assert_select "a[href=?]", cast_path(@cast5), count: 0
      assert_select "a[href=?]", cast_path(@cast6), count: 0
      assert_select "a[href=?]", cast_path(@cast7), count: 0
      assert_select "a[href=?]", cast_path(@cast8), count: 0
      assert_select "a[href=?]", cast_path(@cast9), count: 0
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
      assert_select "a[href=?]", "/movies/list/genre/#{movie.genre_translation}"
      assert_select "a[href=?]", cast_path(@cast1), count: 0
      assert_select "a[href=?]", cast_path(@cast2), count: 0
      assert_select "a[href=?]", cast_path(@cast3), count: 0
      assert_select "a[href=?]", cast_path(@cast4)
      assert_select "a[href=?]", cast_path(@cast5)
      assert_select "a[href=?]", cast_path(@cast6)
      assert_select "a[href=?]", cast_path(@cast7), count: 0
      assert_select "a[href=?]", cast_path(@cast8), count: 0
      assert_select "a[href=?]", cast_path(@cast9), count: 0
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
      assert_select "a[href=?]", "/movies/list/genre/#{movie.genre_translation}"
      assert_select "a[href=?]", cast_path(@cast1), count: 0
      assert_select "a[href=?]", cast_path(@cast2), count: 0
      assert_select "a[href=?]", cast_path(@cast3), count: 0
      assert_select "a[href=?]", cast_path(@cast4), count: 0
      assert_select "a[href=?]", cast_path(@cast5), count: 0
      assert_select "a[href=?]", cast_path(@cast6), count: 0
      assert_select "a[href=?]", cast_path(@cast7)
      assert_select "a[href=?]", cast_path(@cast8)
      assert_select "a[href=?]", cast_path(@cast9)
    end
    assert_select "a[href=?]", movies_list_now_path
    assert_select "a[href=?]", movies_list_rental_coming_path
    assert_select "a[href=?]", movies_list_rental_now_path
    #assert_select "a[href=?]", movies_list_recommended_path
  end
  
  
  
  
  
  #yeartest
  test "should show movies made in 2019 of more" do
    get "/movies/list/year/2100"
    movies = Movie.where(release: "2019/01/01".."2019/12/31")
    movies.each do |movie|
      assert_select 'h5', text: movie.title
      assert_select "a[href=?]", movie_path(movie)
      assert_select "a[href=?]", "/movies/list/genre/#{movie.genre_translation}"
    end
  end
  
  test "should show movies made in 2015 " do
    get "/movies/list/year/2015"
    movies = Movie.where(release: "2015/01/01".."2015/12/31")
    movies.each do |movie|
      assert_select 'h5', text: movie.title
      assert_select "a[href=?]", movie_path(movie)
      assert_select "a[href=?]", "/movies/list/genre/#{movie.genre_translation}"
    end
  end
  
  test "should show movies made in 1990s " do
    get "/movies/list/year/1990"
    movies = Movie.where(release: "1990/01/01".."1999/12/31")
    movies.each do |movie|
      assert_select 'h5', text: movie.title
      assert_select "a[href=?]", movie_path(movie)
      assert_select "a[href=?]", "/movies/list/genre/#{movie.genre_translation}"
    end
  end
  
  test "should show movies made in 1970s of lower" do
    get "/movies/list/year/1960"
    movies = Movie.where(release: "1970/01/01".."1979/12/31")
    movies.each do |movie|
      assert_select 'h5', text: movie.title
      assert_select "a[href=?]", movie_path(movie)
      assert_select "a[href=?]", "/movies/list/genre/#{movie.genre_translation}"
    end
  end
  
  
  
  
  #genretest
  test "should show suspense movies" do
    get "/movies/list/genre/suspense"
    movies = Movie.where(genre: "サスペンス")
    movies.each do |movie|
      assert_select 'h5', text: movie.title
      assert_select "a[href=?]", movie_path(movie)
      assert_select "a[href=?]", "/movies/list/genre/#{movie.genre_translation}"
    end
  end
  
  test "should show documentary movies" do
    get "/movies/list/genre/documentary"
    movies = Movie.where(genre: "ドキュメンタリー")
    movies.each do |movie|
      assert_select 'h5', text: movie.title
      assert_select "a[href=?]", movie_path(movie)
      assert_select "a[href=?]", "/movies/list/genre/#{movie.genre_translation}"
    end
  end
  
  test "should show action movies" do
    get "/movies/list/genre/action"
    movies = Movie.where(genre: "アクション")
    movies.each do |movie|
      assert_select 'h5', text: movie.title
      assert_select "a[href=?]", movie_path(movie)
      assert_select "a[href=?]", "/movies/list/genre/#{movie.genre_translation}"
    end
  end
  
  test "should show SF movies" do
    get "/movies/list/genre/SF"
    movies = Movie.where(genre: "SF")
    movies.each do |movie|
      assert_select 'h5', text: movie.title
      assert_select "a[href=?]", movie_path(movie)
      assert_select "a[href=?]", "/movies/list/genre/#{movie.genre_translation}"
    end
  end
  
  test "should show comedy movies" do
    get "/movies/list/genre/comedy"
    movies = Movie.where(genre: "コメディ")
    movies.each do |movie|
      assert_select 'h5', text: movie.title
      assert_select "a[href=?]", movie_path(movie)
      assert_select "a[href=?]", "/movies/list/genre/#{movie.genre_translation}"
    end
  end
  
  test "should show horror movies" do
    get "/movies/list/genre/horror"
    movies = Movie.where(genre: "ホラー")
    movies.each do |movie|
      assert_select 'h5', text: movie.title
      assert_select "a[href=?]", movie_path(movie)
      assert_select "a[href=?]", "/movies/list/genre/#{movie.genre_translation}"
    end
  end
end
