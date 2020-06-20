class DramasController < ApplicationController
  before_action :year_cut, only:[:year]
  before_action :genre_translate, only:[:genre]
  before_action :production_translate, only:[:production]
  
  def now
    @dramas = Drama.where(status: "放送中").page(params[:page]).per(10)
  end
  
  def rental_coming
    @dramas = Drama.where(status: "レンタル予定").page(params[:page]).per(10)
  end
  
  def rental_now
    @dramas = Drama.where(status: "レンタル").page(params[:page]).per(10)
  end
  
  def show
    @drama = Drama.find(params[:id])
    @reviews = Review.where(drama_id: @drama.id).page(params[:page]).per(10)
    if logged_in?
      @review = get_current_user_review
    end
    @average_star = get_average_star
  end
  
  def year
    if @year.to_i > 2000
      @dramas = Drama.where(release: "#{@year}/01/01".."#{@year}/12/31").page(params[:page]).per(10)
    else
      @dramas = Drama.where(release: "#{@year}/01/01".."#{@year.to_i + 9}/12/31").page(params[:page]).per(10)
    end
  end
  
  def genre
    @dramas = Drama.where(genre: @genre_translated).page(params[:page]).per(10)
  end
  
  def production
    @dramas = Drama.where(production: @production_translated).page(params[:page]).per(10)
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
    
    def genre_translate
      @genre = params[:genre]
      case @genre
      when "suspense" then
        @genre_translated = "サスペンス"
      when "documentary" then
        @genre_translated = "ドキュメンタリー"
      when "action" then
        @genre_translated = "アクション"
      when "SF" then
        @genre_translated = "SF"
      when "comedy" then
        @genre_translated = "コメディ"
      when "horror" then
        @genre_translated = "ホラー"
      end
    end
    
    def production_translate
      @production = params[:production]
      case @production
      when "america" then
        @production_translated = "アメリカ"
      when "england" then
        @production_translated = "イギリス"
      when "spain" then
        @production_translated = "スペイン"
      when "syria" then
        @production_translated = "シリア"
      when "canada" then
        @production_translated = "カナダ"
      when "france" then
        @production_translated = "フランス"
      else
        @production_translated = "アメリカ"
      end
    end
    
    def get_current_user_review
      @reviews.empty? ? nil: @reviews.find_by(user_id: current_user.id)
    end
    
    def get_average_star
      average_star = @reviews.empty? ? 0: @reviews.average(:star).to_f
      if average_star >= 4.5
        4.5
      elsif average_star >= 4.0
        4.0
      elsif average_star >= 3.5
        3.5
      elsif average_star >= 3.0
        3.0
      elsif average_star >= 2.5
        2.5
      elsif average_star >= 2.0
        2.0
      elsif average_star >= 1.5
        1.5
      elsif average_star >= 1.0
        1.0
      elsif average_star >= 0.5
        0.5
      else
        0
      end
    end
end
