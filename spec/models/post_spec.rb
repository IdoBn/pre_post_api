require 'rails_helper'

RSpec.describe Post, :type => :model do
	context "associations" do
		it { should belong_to(:user) }
		it { should have_many(:votes) }

		context 'yes no' do
			let(:user) { FactoryGirl.create(:user) }
			let(:user2) { FactoryGirl.create(:user2) }
			let(:post) { FactoryGirl.create(:post) }

			it 'has many votes_yes' do
				votey = user.votes.create(post_id: post.id, status: 'yes')
				voten = user2.votes.create(post_id: post.id, status: 'no')
				expect(post.votes_yes).to include votey
				expect(post.votes_yes).to_not include voten
			end

			it 'has many votes_no' do
				votey = user.votes.create(post_id: post.id, status: 'yes')
				voten = user2.votes.create(post_id: post.id, status: 'no')
				expect(post.votes_no).to include voten
				expect(post.votes_no).to_not include votey
			end
		end
	end
end
