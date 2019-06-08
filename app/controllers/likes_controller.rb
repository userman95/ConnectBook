class LikesController < ApplicationController
  def create
    p params
    @post = Post.find_by(id: params[:id])
    @like = Like.create(post_id: @post.id,user_id: current_user.id)
    if @like.save
      ######### # TODO: Na ftiaksw to ajax request 
      render partial: 'shared/all_posts',locals: {post: @post }
    end
  end

  private

  def like_params
    params.require(:like).permit(:id)
  end
end
