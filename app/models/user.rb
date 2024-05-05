class User < ApplicationRecord
  include Clearance::User

  has_many :recipes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :nickname, presence: true, uniqueness: true
end
