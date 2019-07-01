class CommentsController < ApplicationController

  before_action :set_post, only: [:create, :index, :destroy]

  def create
    @comment = current_user.comments.build(comment_params)

    if @comment.save
      render formats: :js
    end

  end

  def index
    @comments = @post.comments

    render formats: :js
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy

    render formats: :js
  end

  private

    def set_post
      @post = Post.find_by(id: params[:post_id])
    end

    def comment_params
      params.require(:comment).permit(:content, :post_id)
    end

end
