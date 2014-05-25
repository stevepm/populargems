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
    if user.voted_down_on? comment
      user.likes comment
      comment.user.add_points(10)
    elsif user.voted_up_on? comment
      comment.unliked_by user
      comment.user.subtract_points(10)
    else
      user.likes comment
      comment.user.add_points(10)
    end
    redirect_to :back
  end

  def down_vote
    comment = Comment.find(params[:id])
    user = User.find(params[:user_id])
    if user.voted_up_on? comment
      user.dislikes comment
      comment.user.subtract_points(10)
    elsif user.voted_down_on? comment
      comment.undisliked_by user
      comment.user.add_points(10)
    else
      user.dislikes comment
      comment.user.subtract_points(10)
    end
    redirect_to :back
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :user, :popular_gem)
  end
end