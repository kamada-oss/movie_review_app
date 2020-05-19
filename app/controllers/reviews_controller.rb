class ReviewsController < ApplicationController
  before_action :set_movie_drama, only: [:new, :create]
  before_action :set_screening_time, only: [:new]
  before_action :set_casts, only: [:new]
  before_action :logged_in_user, only:[:new,:create,:edit, :update]
  
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    if @review.valid?
      @review.save
      flash[:success] = "#{@movie_drama.title}を評価しました。"
      redirect_to_movie_or_drama
    else
      flash[:danger] = "投稿出来ませんでした。評価をつけてください。"
      redirect_back(fallback_location: root_path)
    end
  end
  
  def edit
    @review = Review.find(params[:id])
  end
  
  def update
    
  end
  
  private
    def set_movie_drama
      if params[:drama_id].nil?
        @movie_drama = Movie.find(params[:movie_id])
      else
        @movie_drama = Drama.find(params[:drama_id])
      end
    end
    
    def review_params
      if params[:drama_id].nil?
        params.require(:review).permit(:star, :comment).merge(movie_id: params[:movie_id], user_id: current_user.id)
      else
        params.require(:review).permit(:star, :comment).merge(drama_id: params[:drama_id], user_id: current_user.id)
      end
    end
    
    def set_screening_time
      if params[:drama_id].nil?
        @screening_time = @movie_drama.screening_time
      else
        @set_screening_time = 0
      end
    end
    
    def set_casts
      if params[:drama_id].nil?
        @director_ids = @movie_drama.movie_casts.where(relation: "director").select(:cast_id)
        @writer_ids = @movie_drama.movie_casts.where(relation: "writer").select(:cast_id)
        @actor_ids = @movie_drama.movie_casts.where(relation: "actor").select(:cast_id)
      else
        @director_ids = @movie_drama.drama_casts.where(relation: "director").select(:cast_id)
        @writer_ids = @movie_drama.drama_casts.where(relation: "writer").select(:cast_id)
        @actor_ids = @movie_drama.drama_casts.where(relation: "actor").select(:cast_id)
      end
    end
    
    def redirect_to_movie_or_drama
      if params[:drama_id].nil?
        redirect_to movie_path(@movie_drama)
      else
        redirect_to drama_path(@movie_drama)
      end
    end
    
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end
end
