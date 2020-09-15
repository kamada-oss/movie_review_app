class Book < ApplicationRecord
  belongs_to :user
  belongs_to :movie, optional: true
  belongs_to :drama, optional: true
end
