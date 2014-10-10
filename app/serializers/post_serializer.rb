class PostSerializer < ActiveModel::Serializer
  attributes :id, :image_url, :votes_yes, :votes_no

  has_one :user
  has_many :votes_yes
  has_many :votes_no
end
