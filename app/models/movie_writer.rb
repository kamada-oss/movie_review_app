class MovieWriter < ApplicationRecord
  belongs_to :movie
  belongs_to :writer
  validates :movie_id, presence: true
  validates :writer_id, presence: true
end
