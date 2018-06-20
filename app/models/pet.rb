class Pet < ApplicationRecord
  belongs_to :user
  enum pet_type: %i[dog cat]
  validates :name, uniqueness: { scope: :user_id }
end
