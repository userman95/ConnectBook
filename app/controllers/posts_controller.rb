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
    @posts = Post.all
  end

  def edit
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
