class Recipe < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :photo

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :category, presence: true

  def created_by?(user)
    self.user == user
  end
end
