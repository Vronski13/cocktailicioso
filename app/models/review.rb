class Review < ApplicationRecord
  validates :rating, presence: true
  belongs_to :cocktail
  belongs_to :user
end
