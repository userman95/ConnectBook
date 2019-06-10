class LikesController < ApplicationController

  before_action :like_to_be_destroyed, only: [:destroy]

  def create
    p params
    @post = Post.find_by(id: params[:like][:post_id])
    @like = Like.create(user_id: current_user.id, post_id: @post.id)

    respond_to do |format|
      if @like.save
        format.html { redirect_to @like.post, success: 'Liked post!' }
        format.js
      else
        format.html { redirect_back fallback_location: root_path, danger: 'Something went wrong!' }
        format.js
      end
    end
  end

  def destroy
    @like.destroy

    respond_to do |format|
      format.html { redirect_to @like.post }
      format.js
    end
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end

  def like_to_be_destroyed
    @like = Like.find(params[:id])
  end

end
