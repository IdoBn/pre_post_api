class UsersController < ApplicationController
	before_action :authenticate, only: [:index, :show]

	def create
		@user = User.new(user_params)
		if @user.save
			render json: @user
		else
			render json: {errors: @user.errors.full_messages}
		end
	end

	def show
		@user = User.find(params[:id])
		render json: UserSerializer.new(@user).to_json
	end

	def index
		if params[:query].blank?
			render json: { errors: ['search query cannot be blank'] }
		else
			users = User.text_search(params[:query]).paginate(page: params[:page])
			render json: users.map{|u| UserSerializer.new(u)}.to_json
		end
	end

 private
 	def user_params
 		params.require(:user).permit(:email, :password, :password_confirmation, :name)
 	end
end
