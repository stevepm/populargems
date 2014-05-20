class CommentsController < ApplicationController
  def create
    popular_gem = PopularGem.find(params[:comment][:popular_gem])
    Comment.create_from_gem_page(comment_params)
    redirect_to popular_gem
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :user, :popular_gem)
  end
end