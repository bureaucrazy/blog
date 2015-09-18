class FavouritesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post

  def create
    favourite = Favourite.new(post: @post, user: current_user)
    respond_to do |format|
      if favourite.save
        format.html { redirect_to @post } #, notice: "Favourited!"
        format.js   { render }
      else
        format.html { redirect_to @post, alert: "Cannot Favourite!" }
        format.js   { render }
      end
    end
  end

  def destroy
    favourite = Favourite.find params[:id]
    respond_to do |format|
      if can? :destroy, favourite
        favourite.destroy
        format.html { redirect_to @post } #, notice: "Removed Favourite Status!"
        format.js   { render }
      else
        format.html { redirect_to new_user_path, alert: "Access denied!" }
        format.js   { render }
      end
    end
  end

  private

  def find_post
    @post = Post.find params[:post_id]
  end
end
