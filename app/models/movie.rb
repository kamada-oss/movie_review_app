class Movie < ApplicationRecord
  #mount_uploader :picture, PictureUploader
  has_many :movie_casts
   has_many :casts, through: :movie_casts
  has_many :movie_actors
   has_many :actors, through: :movie_actors
  has_many :movie_directors
   has_many :directors, through: :movie_directors
  has_many :movie_writers
   has_many :writers, through: :movie_writers
  validates :title, presence: true, uniqueness: true
end
