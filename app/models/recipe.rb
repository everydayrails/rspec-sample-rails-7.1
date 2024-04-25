class Recipe < ApplicationRecord
  belongs_to :category

  has_one_attached :photo

  validates :name, presence: true
  validates :category, presence: true
end
