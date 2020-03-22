class MoviesController < ApplicationController
  before_action :year_cut, only:[:year]
  
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
  
  def year
    if @year.to_i > 2000
      @movies = Movie.where(release: "#{@year}/01/01".."#{@year}/12/31").page(params[:page]).per(10)
    else
      @movies = Movie.where(release: "#{@year}/01/01".."#{@year.to_i + 9}/12/31").page(params[:page]).per(10)
    end
  end
  
  private
    def year_cut
      @year = params[:year]
      year = @year.to_i
      if(year >= 2020)
        @year = "2019"
      elsif(year >= 2010)
      elsif(year >= 2000)
        @year = "2000"
      elsif(year >= 1990)
        @year = "1990"
      elsif(year >= 1980)
        @year = "1980"
      else
        @year = "1970"
      end
    end
end
