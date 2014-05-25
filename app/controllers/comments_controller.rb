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
    if user.voted_for? comment
      comment.undisliked_by user
    else
      user.likes comment
    end
    redirect_to :back
  end

  def down_vote
    comment = Comment.find(params[:id])
    user = User.find(params[:user_id])
    if user.voted_for? comment
      comment.unliked_by user
    else
      user.dislikes comment
    end
    redirect_to :back
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :user, :popular_gem)
  end
end