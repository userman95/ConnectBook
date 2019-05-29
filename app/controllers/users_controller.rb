class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def send_request
    p params
    @user = User.find_by(id: params[:id])
    current_user.requests_to << @user
    redirect_to users_index_path
  end

  def pending_requests
    @invitations = current_user.invitations_from
  end

  def accept_request

  end
end
