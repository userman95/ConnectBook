class CommentsController < ApplicationController

  before_action :comment_to_be_destroyed, only: :destroy

  def comments_of_post
    @post = Post.find_by(id: params[:id])
    @comments = @post.comments
  end

  def create
    @comment = current_user.comments.build(comment_params)
    @post = @comment.post
    if @comment.save
      respond_to do |format|
        format.html { redirect_to fallback_location: posts_path }
        format.js
      end
    end
  end

  def index
    @post = Post.find_by(id: params[:post_id])
    @comments = @post.comments

    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to fallback_location: posts_path }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

  def comment_to_be_destroyed
    @comment = Comment.find_by(id: params[:id])
  end
end
