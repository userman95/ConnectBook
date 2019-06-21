class FriendshipsController < ApplicationController

  before_action :friendship_to_be_destroyed ,only: [:destroy]
  after_action :destroy_friend_request, only: [:create]

  def create
    @friend = User.find_by(id: params[:friend_id])
    @friendship = current_user.active_friendships.build(friend: @friend)

    if @friendship.save
      flash[:success] = "You are now friends"
      redirect_to posts_path
    end
  end

  def index
    @friendships = current_user.friends
  end

  def destroy
    @friendship.destroy

    render format: :js
  end

  private

    def friendship_to_be_destroyed
      @friendship = Friendship.find_by(friend_id: params[:id])
    end

    def destroy_friend_request
      FriendRequest.where(user: @friend, friend: current_user).first.destroy
    end
end
