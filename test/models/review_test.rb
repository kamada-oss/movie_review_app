require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  def setup
    @user = users(:tanakataro)
    @movie = movies(:movietest1)
    @review = @user.reviews.build(evaluation: "2.0", movie_id: @movie.id)
  end
  
  test "should be valid" do
    assert @review.valid?
  end

  test "user id should be present" do
    @review.user_id = nil
    assert_not @review.valid?
  end
  
  test "evaluation should be present" do
    @review.evaluation = nil
    assert_not @review.valid?
  end
  
  test "order should be most recent first" do
    assert_equal reviews(:review4), Review.first
  end
end
