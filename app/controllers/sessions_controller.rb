class SessionsController < ApplicationController
	 before_action :authenticate, only: [:destroy]

	def create
		user = User.find_by(email: params[:email])
		if user && user.authenticate(params[:password])
			user.set_auth_token
			user.save
			render json: {user: user}
		else
			render_unauthorized
		end
	end

	def destroy
		user = User.find(params[:id])
		user.auth_token = nil
		if user.save
			render json: { status: 'signed out' }
		else
			render json: {errors: @user.errors.full_messages}
		end
	end
end
