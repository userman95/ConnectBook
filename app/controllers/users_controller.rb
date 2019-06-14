class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def send_request
    @user = User.find_by(id: params[:id])
    @friend_request = @user.friend_requests.create(friend: current_user)
    redirect_to users_path
  end

  def pending_requests
    @invitations = current_user.invitations_from
  end

  def show
    @user = User.find_by(id: params[:id])
    @post = current_user.posts.build
    @posts = @user.feed
  end

end
