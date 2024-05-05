class Recipe < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :photo

  validates :name, presence: true
  validates :category, presence: true
end
