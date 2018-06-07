class UserCommentsController < ApplicationController
  def create
    @comment = UserComment.new(comment_params)
    @comment.save
    @comments = UserComment.active.where(visibility: ['partially_visible', 'visible']).order("created_at DESC")
  end
  private
  def comment_params
    params.require(:user_comment).permit(:description, :system_ip)
  end
end
