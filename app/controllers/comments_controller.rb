class CommentsController < ApplicationController
  def create
    Comment.create_from_gem_page(comment_params)
    redirect_to :back
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to :back
  end

  def up_vote
    comment = Comment.find(params[:id])
    user = User.find(params[:user_id])
    comment.undisliked_by user
    user.likes comment
    redirect_to :back
  end

  def down_vote
    comment = Comment.find(params[:id])
    user = User.find(params[:user_id])
    comment.unliked_by user
    user.dislikes comment
    redirect_to :back
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :user, :popular_gem)
  end
end