require "open-uri"

class User < ApplicationRecord
  include Clearance::User

  has_many :recipes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_recipes, through: :favorites, source: :recipe
  has_many :comments, dependent: :destroy
  has_one_attached :avatar

  validates :nickname, presence: true, uniqueness: true
  validates :api_token, presence: true, uniqueness: true

  before_validation :set_api_token, on: :create
  before_create :set_avatar

  def new_to_site?
    created_at > 1.month.ago
  end

  private

  def set_api_token
    begin
      self.api_token = SecureRandom.uuid
    end while self.class.find_by(api_token: api_token).present?
  end

  def set_avatar
    download = URI.open("https://api.dicebear.com/8.x/thumbs/png?seed=#{nickname}")
    self.avatar.attach(io: download, filename: "avatar.png", content_type: "image/png")
  end
end
