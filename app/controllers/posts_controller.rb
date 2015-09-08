class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    if params[:search]
      @posts = Post.search(params[:search]).order(:id)
    else
      @posts = Post.all.order(:id)
    end
  end

  def new
    @post = Post.new(title: "My new post.")
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_path(@post), notice: "Post successfully created."
    else
      flash[:alert] = "Oops.."
      render :new
    end
  end

  def show
    @comment = Comment.new
  end

  def edit

  end

  def update
    @post.update post_params
    redirect_to posts_path
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def find_post
    @post = Post.find params[:id]
  end

  def post_params
    params.require(:post).permit([:title, :body])
  end
end
