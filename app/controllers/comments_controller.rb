class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find params[:post_id]
    @comment = Comment.new comment_params
    @comment.post = @post
    @comment.user = current_user

    if @comment.save
      # CommentsMailer.notify_post_owner(@comment).deliver_now
      CommentsMailer.delay(run_at: 1.minutes.from_now).notify_post_owner(@comment)
      redirect_to post_path(@post), notice: "Comment successfully created."
    else
      # flash[:alert] = "Oops.."
      render "/posts/show"
    end
  end

  def destroy
    @post = Post.find params[:post_id]
    @comment = Comment.find params[:id]
    @comment.destroy
    redirect_to post_path(@post), notice: "Comment successfully deleted."
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
