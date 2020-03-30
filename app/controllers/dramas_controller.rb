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
end
