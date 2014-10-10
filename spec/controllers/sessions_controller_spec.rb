require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
	let(:user){ FactoryGirl.create(:user) }
	

	context 'create' do
		it 'has a successful response' do
			post :create, { email: user.email, password: '123456' }
			expect(response).to be_success
		end

		it 'has a unsuccessful response' do
			post :create, { email: user.email, password: '12345678' }
			expect(response).to_not be_success
		end

		it 'sets the auth_token' do
			post :create, { email: user.email, password: '123456' }
			expect(JSON.parse(response.body)["user"]['auth_token']).to_not be_nil
		end

		it 'expects password_digest to be nil' do
			post :create, { email: user.email, password: '123456' }
			expect(JSON.parse(response.body)['password_digest']).to be_nil
		end
	end

	context 'destroy' do
		context 'success' do
			before(:each) do
				user.set_auth_token
				allow(controller).to receive(:authenticate_token) { true }
				allow(controller).to receive(:current_user) { user }
			end
			# don't know how to test this
			it 'removes auth_token' do
				delete :destroy, { id: user.id }, { 'Authorization' => ActionController::HttpAuthentication::Token.encode_credentials(user.auth_token) }
				expect(user.auth_token).to be_nil
			end

			it 'returns success' do
				delete :destroy, { id: user.id }, { 'Authorization' => ActionController::HttpAuthentication::Token.encode_credentials(user.auth_token) }
				expect(response).to be_success
			end
		end

		context 'failure' do
			it 'returns failure without authorization token' do
				delete :destroy, { id: user.id }, { 'Authorization' => ActionController::HttpAuthentication::Token.encode_credentials(user.auth_token) }
				expect(response).to_not be_success
			end
		end
	end
end
