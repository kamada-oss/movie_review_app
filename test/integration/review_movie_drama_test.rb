require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:tanakataro)
  end
    
  test "should not show review_path when not logged in" do
    @movie = Movie.first
    get movie_path(@movie)
    assert_select "a[href=?]", new_movie_review_path(@movie), count: 0
  end
  
  test "should show review_path when logged in" do
    log_in_as(@user)
    @movie = Movie.first
    get movie_path(@movie)
    assert_select "a[href=?]", new_movie_review_path(@movie)
  end
  
  # test "should show edit_review_path when already create review" do
  #   log_in_as(@user)
  #   @movie = Movie.first
  #   @review = Review.create(movie_id: @movie_id, user_id: @user_id, star: 3.0)
  #   byebug
  #   get movie_path(@movie)
  #   assert_select "a[href=?]", edit_movie_review_path(@movie, @review)
  # end
end  