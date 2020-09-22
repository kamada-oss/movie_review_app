class Like < ApplicationRecord
  belongs_to :user
  belongs_to :cast
  validates :user_id, presence: true
  validates :cast_id, presence: true
end
