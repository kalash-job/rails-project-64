# frozen_string_literal: true

class Web::Posts::CommentsController < Web::ApplicationController
  before_action :authenticate_user!, only: %i[create]
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.post = @post
    if @comment.save
      redirect_to post_path(@post), notice: t('.success')
    else
      @comments = @post.comments.arrange(order: { created_at: :desc })
      @like = PostLike.find_by(post_id: @post.id, user_id: current_user.id)
      @pure_comment = @post.comments.build
      flash.now[:failure] = t('.failure')
      render 'web/posts/show', status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:post_comment).permit(:content, :parent_id)
  end
end
