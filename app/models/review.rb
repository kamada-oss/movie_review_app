class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie, optional: true
  belongs_to :drama, optional: true
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :evaluation, presence: true
  
  def create_date
    mon = created_at.mon < 10 ?  "0#{created_at.mon}" : created_at.mon
    day = created_at.day < 10 ?  "0#{created_at.day}" : created_at.day
    hour = created_at.hour < 10 ?  "0#{created_at.hour}" : created_at.hour
    min = created_at.min < 10 ?  "0#{created_at.min}" : created_at.min
    return "#{created_at.year}/#{mon}/#{day} #{hour}:#{min}"
  end
end
