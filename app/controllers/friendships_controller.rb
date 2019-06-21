class FriendshipsController < ApplicationController

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
    @friendship = Friendship.find_by(friend_id: params[:id])
    @friendship.destroy

    render format: :js
  end

end
