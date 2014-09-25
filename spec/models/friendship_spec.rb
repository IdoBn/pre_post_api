require 'rails_helper'

RSpec.describe Friendship, :type => :model do
	context 'associations' do 
		it { should belong_to(:user) }
  	it { should belong_to(:friend) }
	end

	context 'validations' do
		it { expect(FactoryGirl.build(:friendship, status: 'pending')).to be_valid }
		it { expect(FactoryGirl.build(:friendship, status: 'accepted')).to be_valid }
		it { expect(FactoryGirl.build(:friendship, status: 'rejected')).to be_valid }
		it { expect(FactoryGirl.build(:friendship, status: 'requested')).to be_valid }
		it { expect(FactoryGirl.build(:friendship, status: 'something')).to_not be_valid }
	end

	it 'creates 2 friendships' do
		user = FactoryGirl.create(:user)
		friend = FactoryGirl.create(:user2)
		Friendship.request(user.id, friend.id)

		expect(user.pending_friends).to include(friend)
		expect(friend.friend_requests).to include(user)
	end

	it 'acceptes friend requests' do
		user = FactoryGirl.create(:user)
		friend = FactoryGirl.create(:user2)
		Friendship.request(user.id, friend.id)
		Friendship.accept(friend.id, user.id)

		expect(user.friends).to include(friend)
		expect(friend.friends).to include(user)
	end
end
