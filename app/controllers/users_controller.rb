class UsersController < ApplicationController
	def create
		@user = User.new(user_params)
		if @user.save
			@user.set_auth_token
			render json: { user: @user }
		else
			render json: {errors: @user.errors.full_messages}
		end
	end

 private
 	def user_params
 		params.require(:user).permit(:email, :password, :password_confirmation)
 	end
end
