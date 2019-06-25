class PostsController < ApplicationController


  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      if params[:checked_url].include?("users")
        redirect_to user_path(@post.user)
      else
        flash[:success] = "Post created"
        redirect_to posts_path
      end
    else
      flash[:danger] = "Post not created"
      @user = @post.user
      @posts = Post.all
      render 'users/show'
    end
  end

  def index
    @post = current_user.posts.build
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find_by(id: params[:id])

    @post.destroy
    render formats: :js

  end

  private

  def post_params
    params.require(:post).permit(:content, :picture, :checked_url)
  end
end
