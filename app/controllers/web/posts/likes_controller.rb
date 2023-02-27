# frozen_string_literal: true

class Web::Posts::LikesController < Web::ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.build(post_params)
    if @like.save
      redirect_to post_path(@post)
    else
      root_comments = PostComment.comments_by_post(@post.id).root_comments.by_creation_date_desc
      @comments = root_comments.map { |comment| PostComment.comments_subtree(comment) }
      @like = PostLike.likes_by_post(@post.id).likes_by_user(current_user.id).first
      @comment = @post.comments.build
      render 'web/posts/show', status: :unprocessable_entity
    end
  end

  def destroy
    @like = PostLike.find(params[:id])
    @post = @like.post
    is_users_like = @like.user == current_user
    if is_users_like && @like.destroy
      redirect_to post_path(@post)
    else
      render 'web/posts/show', status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.permit(:post_id)
  end
end
