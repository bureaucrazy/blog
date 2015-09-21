class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :find_post, only: [:show, :edit, :update, :destroy, :lock]
  before_action :authorize!, only: [:edit, :update, :destroy]

  PER_PAGE = 10

  def index
    @viewing_posts = true

    if params[:search]
      @posts = Post.search(params[:search]).order("#{params[:order]}").page(params[:page]).per(PER_PAGE)
    else
      @posts = Post.order("#{params[:order]}").page(params[:page]).per(PER_PAGE)
    end
  end

  def new
    @post = Post.new(title: "My new post.")
  end

  def create
    @post      = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to post_path(@post), notice: "Post successfully created."
    else
      flash[:alert] = "Oops.."
      render :new
    end
  end

  def show
    respond_to do |format|
      @comment = Comment.new
      @favourite = @post.favourites.find_by_user_id(current_user.id) if user_signed_in?

      format.html { render }
      format.json { render json: @post }
    end
  end

  def edit

  end

  def update
    if @post.update post_params
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  # def lock
  #   puts ">>>>>>>>>>> #{@post}"
  #   @post.locked = !@post.locked
  #   @post.save
  #   redirect_to post_path(@post)
  # end

  private

  def authorize!
    # redirect_to root_path, alert: "Access denied!" unless can? :manage, @post
    redirect_to post_path(@post), alert: "Access denied!" unless can? :manage, @post
  end

  def find_post
    @post = Post.find params[:id]
  end

  def post_params
    params.require(:post).permit([:title, :body, :image, {tag_ids: []}, :locked, :category_id])
  end
end
