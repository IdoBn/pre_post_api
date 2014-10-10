class PostsController < ApplicationController
	# before_action :authenticate

	def index
		ids = current_user.friends.pluck(:id)
		@posts = Post.where(user_id: ids).order("created_at DESC").paginate(page: params[:page])
		render json: @posts.map{|p| PostSerializer.new(p)}.to_json
	end

	def show
		@post = Post.find(params[:id])
		render json: PostSerializer.new(@post).to_json
	end
end
