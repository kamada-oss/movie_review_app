class ReviewsController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
    @user = User.find(params[:id])
    @reviews = @user.revies.where(movie_id: @movie_id)
  end
end
