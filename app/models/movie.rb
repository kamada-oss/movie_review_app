class Movie < ApplicationRecord
  #mount_uploader :picture, PictureUploader
  attr_accessor :genre_translated
  has_many :movie_casts
   has_many :casts, through: :movie_casts
  has_many :movie_actors
   has_many :actors, through: :movie_actors
  has_many :movie_directors
   has_many :directors, through: :movie_directors
  has_many :movie_writers
   has_many :writers, through: :movie_writers
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
end
