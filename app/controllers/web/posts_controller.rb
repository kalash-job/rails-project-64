# frozen_string_literal: true

class Web::PostsController < Web::ApplicationController
  def index
    @posts = Post.ordered
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      redirect_to root_path
      flash[:success] = t('.success')
    else
      render :new, status: :unprocessable_entity
      flash[:failure] = t('.failure')
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id, :creator_id)
  end
end
