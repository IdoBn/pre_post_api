require 'rails_helper'

RSpec.describe FriendshipsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user2) }
  before(:each) do
    user.set_auth_token
    allow(controller).to receive(:authenticate_token) { true }
    allow(controller).to receive(:current_user) { user }
  end

  describe "POST create" do
    it "creates friend request" do
      post :create, { friend_id: user2.id }
      expect(user.pending_friends).to include(user2)
      expect(user2.friend_requests).to include(user)
    end
  end

  describe "DELETE destroy" do
    it "it destroys friend request" do
      Friendship.request(user.id, user2.id)
      Friendship.accept(user2.id, user.id)
      friend_request = user.friendships.where(friend_id: user2.id).first#Friendship.where(user_id: user.id, friend_id: user2.id).first
      expect {
        delete :destroy, { id: friend_request.id }    
      }.to change { user.friends.count }.by(-1)
    end

    it "removes users from each other's friends" do
      Friendship.request(user.id, user2.id)
      Friendship.accept(user2.id, user.id)
      friend_request = user.friendships.where(friend_id: user2.id).first
      delete :destroy, { id: friend_request.id }    

      expect(user.friends).to_not include(user2)
      expect(user2.friends).to_not include(user)
    end

    it "doesn't remove if not user" do
      Friendship.request(user.id, user2.id)
      Friendship.accept(user2.id, user.id)
      friend_request = user2.friendships.where(friend_id: user.id).first
      
      expect {
        delete :destroy, { id: friend_request.id }            
      }.to change { user2.friends.count }.by(0)
    end
  end

end
