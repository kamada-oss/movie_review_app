class Drama < ApplicationRecord
  attr_accessor :genre_translated
  attr_accessor :production_translated
  has_many :drama_casts
   has_many :casts, through: :drama_casts
  has_many :reviews
   has_many :users, through: :reviews
  has_many :books
   has_many :users, through: :books
   
  validates :title, presence: true, uniqueness: true
   
  def genre_translation
    case genre
    when "サスペンス" then
      self.genre_translated = "suspense"
    when "ドキュメンタリー" then
      self.genre_translated = "documentary"
    when "アクション" then
      self.genre_translated = "action"
    when "SF" then
      self.genre_translated = "SF"
    when "コメディ" then
      self.genre_translated = "comedy"
    when "ホラー" then
      self.genre_translated = "horror"
    else
      self.genre_translated = "suspense"
    end
  end
  
  def production_translation
    case production
    when "アメリカ" then
      self.production_translated = "america"
    when "イギリス" then
      self.production_translated = "england"
    when "スペイン" then
      self.production_translated = "spain"
    when "シリア" then
      self.production_translated = "syria"
    when "カナダ" then
      self.production_translated = "canada"
    when "フランス" then
      self.production_translated = "france"
    else
      self.production_translated = "america"
    end
  end
end
