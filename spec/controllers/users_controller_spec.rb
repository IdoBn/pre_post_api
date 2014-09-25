require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

	context 'GET index' do
		let(:user) { FactoryGirl.create(:user) }
		let(:user2) { FactoryGirl.create(:user2) }
		before(:each) do
			allow(controller).to receive(:authenticate_token) { true }
			allow(controller).to receive(:current_user) { user }
		end

		it 'responds to search term' do
			get :index, { query: user2.name }
			expect(JSON.parse(response.body)['users']).to include(JSON.parse(user2.to_json))
		end
	end

	context 'show' do
		let(:user) { FactoryGirl.create(:user) }
	  before(:each) do
	    user.set_auth_token
	    allow(controller).to receive(:authenticate_token) { true }
	    allow(controller).to receive(:current_user) { user }
	  end

	  it 'renders user json' do
	  	get :show, { id: user.id }
	  	expect(JSON.parse(response.body)['user']['email']).to eq(user.email)
	  end
	end

	context 'create' do
		let(:user_params) { ({user: { email: 'yosi@gmail.com', password: '12345', password_confirmation: '12345', name: 'yosi' }}) }
		it 'creates a user' do
			expect {
				post :create, user_params
			}.to change { User.count }.by(1)
		end

		it 'creates a user' do
			post :create, user_params
			expect(JSON.parse(response.body)['user']['email']).to eq(user_params[:user][:email])
		end

		it 'should not create user with bad params' do
			expect {
				post :create, {user: { email: 'dodoAtGmailDotCom', password: '12345', password_confirmation: '', name: 'dodo' }}
			}.to change { User.count }.by(0)
		end

		it 'should create an auth token' do
			post :create, user_params
			expect(JSON.parse(response.body)['user']['auth_token']).to_not be_nil
		end
	end

end
