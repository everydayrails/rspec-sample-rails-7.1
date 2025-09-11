class Recipe < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :photo

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :category, presence: true

  scope :by_word_in_name, ->(query) {
    where("name LIKE ?", "%#{query}%") if query.present?
  }

  scope :by_popularity, ->() {
    left_joins(:favorites)
      .group(:id)
      .order("COUNT(favorites.id) DESC")
  }

  def created_by?(user)
    self.user == user
  end

  def photo_url
    if photo.attached?
      photo
    else
      "recipe-placeholder.png"
    end
  end
end
