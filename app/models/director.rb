class Director < ApplicationRecord
  has_many :movie_directors
   has_many :movies, through: :movie_directors
  validates :name, presence: true, uniqueness: true
end
