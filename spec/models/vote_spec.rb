require 'rails_helper'

RSpec.describe Vote, :type => :model do
	context 'validations' do
		it { should validate_presence_of(:status) }
		it { expect(FactoryGirl.build(:vote, status: 'no')).to be_valid }
		it { expect(FactoryGirl.build(:vote, status: 'yes')).to be_valid }
		it { expect(FactoryGirl.build(:vote, status: 'dodo')).to_not be_valid }

		it 'validates that a user can not have two votes on the same post' do
			user = FactoryGirl.create(:user)
			post = FactoryGirl.create(:post, user_id: user.id)

			expect {
				user.votes.create(post_id: post.id, status: 'yes')
				user.votes.create(post_id: post.id, status: 'no')  
			}.to change { post.votes.count }.by 1
		end
	end

	context 'associations' do
		it { should belong_to(:user) }
		it { should belong_to(:post) }
	end
end
