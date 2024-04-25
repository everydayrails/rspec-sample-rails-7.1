class Recipe < ApplicationRecord
  belongs_to :category

  validates :name, presence: true
  validates :category, presence: true
end
