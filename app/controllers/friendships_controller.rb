class FriendshipsController < ApplicationController
	before_action :authenticate

  def create
  	@friendship = Friendship.request(current_user.id, params[:friend_id])
  	if @friendship.save
  		render json: { friendship: @friendship }
  	else
  		render json: { errors: @friendship.errors.full_message }
  	end
  end

  def accept
  	Friendship.accept(current_user.id, params[:friend_id])
  	render json: { friendship: friendship }
  end

  def reject
  	# tbd
  end

  def destroy
  	if friendship && friendship.destroy
  		render json: { status: 'friend removed' }
  	else
  		render json: { errors: 'could not delete friend' }
  	end
  end

 private
 	def friendship
 		@friendship ||= current_user.friendships.find(params[:id])
 	rescue
 		false
 	end
end
