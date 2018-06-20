class UserSerializer < ActiveModel::Serializer
  attributes :email, :role, :created_at, :updated_at
end
