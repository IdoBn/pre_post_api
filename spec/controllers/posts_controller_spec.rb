require 'rails_helper'

RSpec.describe PostsController, :type => :controller do
	let(:user) { FactoryGirl.create(:user) }
	let(:user2) { FactoryGirl.create(:user2) }
	let(:user3) { FactoryGirl.create(:user, email: 'ido.bennatan@gmail.com', name: 'dodo') }
	before(:each) do
		allow(controller).to receive(:authenticate_token) { true }
		allow(controller).to receive(:current_user) { user }
	end

	context 'GET #index' do
		before(:each) do
			Friendship.request(user.id, user2.id)
      Friendship.accept(user2.id, user.id)

      Friendship.request(user.id, user3.id)
      Friendship.accept(user3.id, user.id)
		end

		it 'should be success' do
			get :index
			expect(response).to be_success
		end

		it 'should include friends posts' do
			posts = []
			posts << user2.posts.create
			posts << user3.posts.create
			get :index
			posts.each do |post|
				body = JSON.parse(response.body)
				expect(body.map { |p| post.id }).to include post.id
				expect(body.map { |p| post.image_url }).to include post.image_url
				expect(body.map { |p| post.user.id }).to include post.user.id
			end
		end
	end

	context 'GET #show' do
		let(:user_post) { user.posts.create }
		before(:each) { user_post }

		it 'should be success' do
			get :show, {id: user_post.id}
			expect(response).to be_success
		end

		it 'should return the post' do 
			get :show, { id: user_post.id }
			body = JSON.parse(response.body)["post"]
			expect(body["image_url"]).to eq user_post.image_url
			expect(body["id"]).to eq user_post.id
		end
 	end
end
