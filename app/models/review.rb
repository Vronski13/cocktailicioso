class Review < ApplicationRecord
  validates :rating, presence: true, inclusion: { in: [1, 2, 3, 4, 5] }
  belongs_to :cocktail
  belongs_to :user
end
