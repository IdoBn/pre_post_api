class PostSerializer < ActiveModel::Serializer
  attributes :id, :image_url

  has_one :user
end
