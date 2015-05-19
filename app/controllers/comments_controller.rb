class CommentsController < ApplicationController
  def create
    @comment = current_user.authored_comments.new(comment_params)

    if @comment.save
      flash[:success] = "Comment created!"
      if @comment.commentable_type == "User"
        redirect_to user_url(@comment.commentable_id)
      else
        redirect_to user_url(@comment.commentable.user_id)
      end
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    if @comment.commentable_type == "User"
      redirect_to user_url(@comment.commentable_id)
    else
      redirect_to user_url(@comment.commentable.user_id)
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body, :commentable_id, :commentable_type)
    end
end
