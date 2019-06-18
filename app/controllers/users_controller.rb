class UsersController < ApplicationController
  def index
    @users = if params[:search]
      User.where('name LIKE ?', "%#{params[:search]}%")
    else
      User.all
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @post = current_user.posts.build
    @posts = @user.feed
  end


end
