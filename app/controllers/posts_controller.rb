class PostsController < ApplicationController
	before_action :authenticate

	def index
		ids = current_user.friends.pluck(:id)
		@posts = Post.where(user_id: ids).order("created_at DESC").paginate(page: params[:page])
		render json: @posts, each_serializer: PostSerializer
	end

	def show
		@post = Post.find(params[:id])
		render json: @post
		# render json: @user, serializer: PrivateUserSerializer, root: "user"
	end
end
