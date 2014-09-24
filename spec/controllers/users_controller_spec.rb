require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

	context 'create' do
		let(:user_params) { ({user: { email: 'yosi@gmail.com', password: '12345', password_confirmation: '12345' }}) }
		it 'creates a user' do
			expect {
				post :create, user_params
			}.to change { User.count }.by(1)
		end

		it 'creates a user' do
			post :create, user_params
			expect(JSON.parse(response.body)['user']['email']).to eq(user_params[:user][:email])
		end
	end

end
