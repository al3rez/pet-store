class CategorySerializer < ActiveModel::Serializer
  belongs_to :user
  has_many :pets
  attributes :id, :name, :created_at, :updated_at

  def id
    object.hashid
  end
end
