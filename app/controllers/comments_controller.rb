class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find params[:post_id]
    @comment = Comment.new comment_params
    @comment.post = @post
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        # CommentsMailer.notify_post_owner(@comment).deliver_now
        CommentsMailer.delay(run_at: 1.minutes.from_now).notify_post_owner(@comment)
        format.html { redirect_to post_path(@post), notice: "Comment successfully created." }
        format.js   { render :create_success }
      else
        # flash[:alert] = "Oops.."
        format.html { render "/posts/show" }
        format.js   { render js: "alert(\"Comment not saved\");"}
      end
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
