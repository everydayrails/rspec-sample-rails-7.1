class User < ApplicationRecord
  include Clearance::User

  has_many :recipes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_recipes, through: :favorites, source: :recipe
  has_many :comments, dependent: :destroy

  validates :nickname, presence: true, uniqueness: true
  validates :api_token, presence: true, uniqueness: true

  before_validation :set_api_token, on: :create

  private

  def set_api_token
    begin
      self.api_token = SecureRandom.uuid
    end while self.class.find_by(api_token: api_token).present?
  end
end
