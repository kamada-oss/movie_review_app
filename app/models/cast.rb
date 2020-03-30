class Cast < ApplicationRecord
  has_many :movie_casts
   has_many :movies, through: :movie_casts
  has_many :drama_casts
   has_many :dramas, through: :drama_casts
  validates :name, presence: true, uniqueness: true
end
