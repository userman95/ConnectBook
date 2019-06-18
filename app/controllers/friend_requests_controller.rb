class FriendRequestsController < ApplicationController

  def create
    @friend_request = current_user.friend_requests.build(friend_id: params[:friend_id])
    @user = User.find_by(id: params[:friend_id])

    if @friend_request.save
      respond_to do |format|
        format.html { redirect_to  users_path }
        format.js
      end
    else
      flash[:danger] = 'Could not send the request'
      redirect_to users_path
    end
  end

  def index
    @friend_requests = current_user.received_requests
  end

  def destroy
    @friend_request = FriendRequest.find_by(id: params[:id])
    @friend_request.destroy

    respond_to do |format|
      format.html { redirect_to friend_requests_path }
      format.js
    end
  end

end
