class Category < ApplicationRecord
  belongs_to :user
  has_many :pets
  validates :name, uniqueness: { scope: :user_id }
end
