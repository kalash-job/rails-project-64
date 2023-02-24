# frozen_string_literal: true

class Web::Posts::CommentsController < Web::ApplicationController
  before_action :authenticate_user!, only: %i[create]
  def create
    @post = Post.find(post_params)
    @comment = current_user.comments.build(comment_params)
    @comment.post = @post
    if @comment.save
      redirect_to post_path(@post), notice: t('.success')
    else
      root_comments = PostComment.comments_by_post(@post.id).root_comments.by_creation_date_desc
      @comments = root_comments.map { |comment| PostComment.comments_subtree(comment) }
      @pure_comment = @post.comments.build
      flash[:failure] = t('.failure')
      render 'web/posts/show', status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:post_comment).permit(:content, :parent_id)
  end

  def post_params
    params.require(:post_id)
  end
end
