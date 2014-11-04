class CommentsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @comment = @user.comments.new(comments_params)
    @comment.user_id = current_user.id
    
    @comment.save
    flash[:errors] = @comment.errors.full_messages
    redirect_to user_url(@user)
  end
  
  private
  
  def comments_params
    params.require(:comment).permit(:body)
  end
end
