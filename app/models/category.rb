class Category < ApplicationRecord
  include Hashid::Rails

  belongs_to :user
  has_many :pets
  validates :name, uniqueness: { scope: :user_id }
end
