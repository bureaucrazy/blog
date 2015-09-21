class HomeController < ApplicationController
  def index
    @latest_post = Post.last
    render :index, layout: "application"
  end

  def about
    render :about, layout: "application"
  end
end
