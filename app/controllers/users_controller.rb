class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def send_request
    p params
    @user = User.find_by(id: params[:id])
    @friend_request = @user.friend_requests.create(friend: current_user)
    redirect_to users_index_path
  end

  def pending_requests
    @invitations = current_user.invitations_from
  end

  def accept_request

  end

end
