class AuthUserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :auth_token
  root 'user'
end
