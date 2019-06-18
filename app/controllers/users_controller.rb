class UsersController < ApplicationController
  def index
    @users = if params[:search]
      User.where('name LIKE ?', "%#{params[:search]}%")
    else
      User.where('id NOT IN (SELECT DISTINCT(friend_id) FROM friendships) AND id NOT IN (SELECT DISTINCT(friend_id) FROM friendships)')
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @post = current_user.posts.build
    @posts = @user.feed
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.update_attributes(image: params[:user][:image])

    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  private

  def user_params
    params.require(:user).permit(:image)
  end

end
