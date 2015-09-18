class FavouritesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post

  def create
    favourite = Favourite.new(post: @post, user: current_user)
    if favourite.save
      redirect_to @post #, notice: "Favourited!"
    else
      redirect_to @post, alert: "Cannot Favourite!"
    end
  end

  def destroy
    favourite = Favourite.find params[:id]
    if can? :destroy, favourite
      favourite.destroy
      redirect_to @post #, notice: "Removed Favourite Status!"
    else
      redirect_to new_user_path, alert: "Access denied!"
    end
  end

  private

  def find_post
    @post = Post.find params[:post_id]
  end
end
