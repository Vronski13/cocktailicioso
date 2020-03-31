class Cocktail < ApplicationRecord
  has_one_attached :photo
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  has_many :reviews
  belongs_to :user
  validates :name, presence: true, uniqueness: true
  include PgSearch::Model
  multisearchable against: :name
end
