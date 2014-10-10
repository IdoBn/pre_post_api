class SessionsController < ApplicationController
	 before_action :authenticate, only: [:destroy]

	def create
		user = User.find_by(email: params[:email])
		if user && user.authenticate(params[:password])
			user.set_auth_token
			user.save
			render :json => { user: user.as_json(only: [:id, :name, :auth_token, :email]) } 
		else
			render_unauthorized
		end
	end

	def destroy
		current_user.auth_token = nil
		if current_user.save
			render json: { status: 'signed out' }
		else
			render json: {errors: current_user.errors.full_messages}
		end
	end
end
