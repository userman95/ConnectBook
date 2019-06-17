class PostsController < ApplicationController
  def new
  end

  def create
    @post = current_user.posts.create(post_params)
    if @post.save
      redirect_to posts_path
    end
  end

  def index
    p params
    @posts = Post.newer_posts
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:content, :like)
  end
end
