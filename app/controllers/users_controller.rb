class UsersController < ApplicationController
	before_action :authenticate, only: [:index, :show]

	def create
		@user = User.new(user_params)
		if @user.save
			render json: { user: @user }
		else
			render json: {errors: @user.errors.full_messages}
		end
	end

	def show
		@user = User.find(params[:id])
		render json: { user: @user }
	end

 private
 	def user_params
 		params.require(:user).permit(:email, :password, :password_confirmation, :name)
 	end
end
