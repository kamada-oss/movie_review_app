class MoviesController < ApplicationController
  def now
    @movies = Movie.where(status: "公開中").page(params[:page]).per(10)
    #Movie.where(status: "公開中") ← Movieモデルからstatusが"公開中"のレコードを抽出
    #page(params[:page]).per(10) ← ページパラメータを取得(10件毎)
  end
  
  def rental_coming
    @movies = Movie.where(status: "レンタル予定").page(params[:page]).per(10)
  end
  
  def rental_now
    @movies = Movie.where(status: "レンタル").page(params[:page]).per(10)
  end
  
  def show
    @movie = Movie.find(params[:id])
  end
end
