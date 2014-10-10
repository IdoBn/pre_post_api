class PostSerializer < ActiveModel::Serializer
  attributes :id, :image_url, :votes_yes, :votes_no

  has_one :user

  def votes_yes
  	object.votes_yes.count
  end

  def votes_no
  	object.votes_no.count
  end
end
