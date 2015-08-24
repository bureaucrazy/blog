class HomeController < ApplicationController
  def index
    render :index, layout: "application"
  end

  def about
    render :about, layout: "application"
  end
end
