require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:tanakataro)
    @movie = movies(:movietest2)
    @drama = dramas(:dramatest2)
  end
  
  test "should redirect new when not login on movie" do
    get new_movie_review_path(@movie)
    assert_redirected_to login_url
  end
  
  test "should redirect create when not login on movie" do
    post movie_reviews_path(@movie), params: {review: {star: "3.0", comment: "aaa"}}
    assert_redirected_to login_url
  end
  
  test "should redirect new when not login on drama" do
    get new_drama_review_path(@drama)
    assert_redirected_to login_url
  end
  
  test "should redirect create when not login on drama" do
    post drama_reviews_path(@drama), params: {review: {star: "3.0", comment: "aaa"}}
    assert_redirected_to login_url
  end
  
  test "should success create on movie" do
    log_in_as(@user)
    assert_difference 'Review.count', 1 do
      post movie_reviews_path(@movie), params: {review: {star: "3.0", comment: "aaa"}}
    end
    follow_redirect!
    assert_template 'movies/show'
  end
  
  test "should success create when comment blank on movie" do
    log_in_as(@user)
    assert_difference 'Review.count', 1 do
      post movie_reviews_path(@movie), params: {review: {star: "3.0", comment: ""}}
    end
    follow_redirect!
    assert_template 'movies/show'
  end
  
  test "should not create when star blank on movie" do
    log_in_as(@user)
    assert_difference 'Review.count', 0 do
      post movie_reviews_path(@movie), params: {review: {star: "", comment: "aaa"}}
    end
  end
  
  test "should success create on drama" do
    log_in_as(@user)
    assert_difference 'Review.count', 1 do
      post drama_reviews_path(@drama), params: {review: {star: "3.0", comment: "aaa"}}
    end
    follow_redirect!
    assert_template 'dramas/show'
  end
  
  test "should success create when comment blank on drama" do
    log_in_as(@user)
    assert_difference 'Review.count', 1 do
      post drama_reviews_path(@drama), params: {review: {star: "3.0", comment: ""}}
    end
    follow_redirect!
    assert_template 'dramas/show'
  end
  
  test "should not create when star blank on drama" do
    log_in_as(@user)
    assert_difference 'Review.count', 0 do
      post drama_reviews_path(@drama), params: {review: {star: "", comment: "aaa"}}
    end
  end
end
