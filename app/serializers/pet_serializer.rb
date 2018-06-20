class PetSerializer < ActiveModel::Serializer
  belongs_to :owner
  attributes :id, :name, :pet_type, :created_at, :updated_at

  def owner
    object.user
  end
end
