require 'rails_helper'

RSpec.describe VotesController, :type => :controller do
	context 'signed in' do
		let(:user) { FactoryGirl.create(:user) }
		# let(:user2) { FactoryGirl.create(:user2) }
		let(:user_post) { FactoryGirl.create(:post) }
		before(:each) do
			allow(controller).to receive(:authenticate_token) { true }
			allow(controller).to receive(:current_user) { user }
		end

		context 'POST #yes' do
			it 'creates a new vote' do
				expect {
					post :yes, { post_id: user_post.id }
				}.to change { user_post.votes_yes.length }.by 1
			end	

			it '200 response' do
				post :yes, { post_id: user_post.id }
				expect(response).to be_success
			end
		end

		context 'POST #no' do
			it 'creates a new vote' do
				expect {
					post :no, { post_id: user_post.id }					
				}.to change{ user_post.votes_no.length }.by 1
			end

			it '200 response' do
				post :no, { post_id: user_post.id }
				expect(response).to be_success
			end
		end
	end
end
