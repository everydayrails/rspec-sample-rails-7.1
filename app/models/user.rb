class User < ApplicationRecord
  include Clearance::User

  has_many :recipes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :nickname, presence: true, uniqueness: true
  validates :api_token, presence: true, uniqueness: true

  after_create :set_api_token

  private

  def set_api_token
    begin
      self.api_token = SecureRandom.uuid
    end while self.class.exists?(api_token: api_token)

    save
  end
end
