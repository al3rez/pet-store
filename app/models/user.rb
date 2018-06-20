class User < ApplicationRecord
  has_secure_password
  enum role: %i[manager pet_owner customer]
  validates :email, uniqueness: true

  has_many :pets
  has_many :categories
end
