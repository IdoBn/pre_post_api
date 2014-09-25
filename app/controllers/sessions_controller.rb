class SessionsController < ApplicationController
	def create
		user = User.where(email: params[:email]).first
		if user && user.authenticate(params[:password])
			user.set_auth_token
			render json: {user: user}
		else
			render json: {error: 'un authorized'}, status: :unauthorized
		end
	end
end
