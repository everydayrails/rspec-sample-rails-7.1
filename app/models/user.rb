class User < ApplicationRecord
  include Clearance::User

  has_many :recipes, dependent: :destroy
  has_many :favorites, dependent: :destroy
end
