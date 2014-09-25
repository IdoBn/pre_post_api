require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
	let(:user){ FactoryGirl.create(:user) }
	

	context 'create' do
		it 'has a successful response' do
			post :create, { email: user.email, password: '12345' }
			expect(response).to be_success
		end

		it 'has a unsuccessful response' do
			post :create, { email: user.email, password: '12345678' }
			expect(response).to_not be_success
		end

		it 'sets the auth_token' do
			post :create, { email: user.email, password: '12345' }
			expect(JSON.parse(response.body)['user']['auth_token']).to_not be_nil
		end
	end

	context 'destroy' do
		# don't know how to test this
		# it 'removes auth_token' do
		# 	user.set_auth_token
		# 	delete :destroy, { id: user.id }, { 'Authorization' => "Token token='#{user.auth_token}'}" }
		# 	# expect(response).to be_success
		# 	expect(JSON.parse(response.body)['status']).to be('signed out')
		# 	# expect(user.auth_token).to be_nil
		# end
	end
end
