class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email params[:email]
    # we check here to make sure that the user exists first if so then we use
    # the `authenticate` method which comes with `has_secure_password` method
    # which we added in the `user.rb`. we set the session to the user id if
    # the user authenticates correctly
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to posts_path #, notice: "Sign in successful!"
    else
      flash[:alert] = "Incorrect login."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Sign out successful!"
  end
end
