class Friendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend, class_name: 'User'

	validates :status, format: /pending|requested|accepted|rejected/

	before_destroy :remove_both_sides

	def remove_both_sides
		self.user.friends.delete(self.friend)
  	self.friend.friends.delete(self.user)
	end

	def self.accept_one_side(user_id, friend_id, accepted_at)
		request = where(user_id: user_id, friend_id: friend_id).first
    request.status = 'accepted'
    request.accepted_at = accepted_at
    request.save!
	end

	def self.accept(user_id, friend_id)
		transaction do
      accepted_at = Time.now
      accept_one_side(user_id, friend_id, accepted_at)
      accept_one_side(friend_id, user_id, accepted_at)
    end
	end

	def self.request(user_id , friend_id)
    unless user_id == friend_id || Friendship.exists?(user_id: user_id, friend_id: friend_id)
      transaction do
        create(:user_id => user_id, :friend_id => friend_id, :status => 'pending')
        create(:user_id => friend_id, :friend_id => user_id, :status => 'requested')
      end
    end
  end
end
