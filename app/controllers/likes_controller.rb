class LikesController < ApplicationController

  before_action :set_post, only: [:create, :destroy]

  def create
    @like = current_user.likes.build(like_params)

    if @like.save
      render formats: :js
    else
      render formats: :js
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy

    render formats: :js
  end

  private

    def like_params
      params.require(:like).permit(:post_id)
    end

    def set_post
      @post = Post.find_by(id: params[:post_id])
    end

end
