class CommentsController < ApplicationController
  def create
    comment = params[:comment][:body]
    @comment = Comment.create_from_gem_page(comment_params)
    if !@comment.valid? || comment.blank?
      @gem = PopularGem.friendly.find(params[:comment][:popular_gem])
      @comments = @gem.comment_threads.order(cached_votes_score: :desc)
      render "popular_gems/show"
    else
      current_user.add_points(3)
      gem = PopularGem.friendly.find(params[:comment][:popular_gem])
      redirect_to gem
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    gem = PopularGem.find(comment.commentable_id)
    comment.destroy
    current_user.subtract_points(3)
    redirect_to gem
  end

  def up_vote
    comment = Comment.find(params[:id])
    user = User.find(params[:user_id])
    if user.voted_down_on? comment
      user.likes comment
      comment.user.add_points(12)
    elsif user.voted_up_on? comment
      comment.unliked_by user
      comment.user.subtract_points(6)
    else
      user.likes comment
      comment.user.add_points(6)
    end
    redirect_to :back
  end

  def down_vote
    comment = Comment.find(params[:id])
    user = User.find(params[:user_id])
    if user.voted_up_on? comment
      user.dislikes comment
      comment.user.subtract_points(12)
    elsif user.voted_down_on? comment
      comment.undisliked_by user
      comment.user.add_points(6)
    else
      user.dislikes comment
      comment.user.subtract_points(6)
    end
    redirect_to :back
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :user, :popular_gem)
  end
end