# frozen_string_literal: true

class Web::PostsController < Web::ApplicationController
  before_action :authenticate_user!, only: %i[new create]
  def index
    @posts = Post.by_creation_date_desc.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    root_comments = PostComment.comments_by_post(@post.id).root_comments.by_creation_date_desc
    @comments = root_comments.map { |comment| PostComment.comments_subtree(comment) }
    @comment = @post.comments.build
    @pure_comment = @post.comments.build
    @like = current_user.nil? ? nil : PostLike.likes_by_post(@post.id).likes_by_user(current_user.id).first
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to root_path, notice: t('.success')
    else
      flash.now[:failure] = t('.failure')
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id, :creator_id)
  end
end
