# frozen_string_literal: true

class Web::PostsController < Web::ApplicationController
  before_action :authenticate_user!, only: %i[new create]
  def index
    @posts = Post.by_creation_date_desc.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.arrange(order: { created_at: :desc })
    @comment = @post.comments.build
    @pure_comment = @post.comments.build
    @like = current_user.nil? ? nil : PostLike.find_by(post_id: @post.id, user_id: current_user.id)
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
