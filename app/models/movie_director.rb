class MovieDirector < ApplicationRecord
  belongs_to :movie
  belongs_to :director
  validates :movie_id, presence: true
  validates :director_id, presence: true
end
