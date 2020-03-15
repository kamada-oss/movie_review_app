class MoviesController < ApplicationController
  def now
    @movies = Movie.where(status: "公開中").page(params[:page]).per(10)
  end
  
  def rental_coming
    @movies = Movie.where(status: "レンタル予定").page(params[:page]).per(10)
  end
  
  def rental_now
    @movies = Movie.where(status: "レンタル").page(params[:page]).per(10)
  end
end
