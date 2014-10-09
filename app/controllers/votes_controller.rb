class VotesController < ApplicationController
	def yes
		@vote = Vote.new(post_id: params[:post_id], status: 'yes', user_id: current_user.id)
		if @vote.save
			render json: { vote: @vote }
		else
			render json: {errors: @vote.errors.full_messages}
		end
	end

	def no
		@vote = Vote.new(post_id: params[:post_id], status: 'no', user_id: current_user.id)
		if @vote.save
			render json: { vote: @vote }
		else
			render json: {errors: @vote.errors.full_messages}
		end
	end

 private
 	def render_vote(flag)
 		if flag
			render json: { vote: @vote }
		else
			render json: {errors: @vote.errors.full_messages}
		end
 	end
end
