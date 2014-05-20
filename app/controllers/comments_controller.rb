class CommentsController < ApplicationController
  def create
    popular_gem = PopularGem.find(params[:comment][:popular_gem])
    Comment.create!(body: params[:comment][:body],
                    user: User.find(params[:comment][:user]),
                    popular_gem: popular_gem)
    redirect_to popular_gem
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :user, :popular_gem)
  end
end