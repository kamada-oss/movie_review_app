class Writer < ApplicationRecord
  has_many :movie_writers
   has_many :writers, through: :movie_writers
  validates :name, presence: true, uniqueness: true
end
