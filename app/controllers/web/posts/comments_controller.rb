class Web::Posts::CommentsController < Web::Posts::ApplicationController
  def create
    @post = Post.find(comment_params[:post_id])
    @comments = @post.comments
    @comment = @post.comments.build(comment_params)
    if @comment.save
      redirect_to post_path(@post), notice: "Comment was successfully added."
    else
      render 'web/posts/show', status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :creator_id, :parent_id)
  end
end
