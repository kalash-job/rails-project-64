# frozen_string_literal: true

class Web::Posts::LikesController < Web::ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    current_user.likes.find_or_create_by(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    PostLike.destroy_by(id: params[:id], post_id: @post.id, user_id: current_user.id)
    redirect_to post_path(@post)
  end

  private

  def post_params
    params.permit(:post_id)
  end
end
