class PopularGemsController < ApplicationController
  def index
    @gems = PopularGem.order(total_downloads: :desc).paginate_gems(params[:page])
  end

  def show
    @popular_gem = PopularGem.find(params[:id])
    @comments = @popular_gem.comments.all
    @comment = Comment.new
  end

  def edit
    @popular_gem = PopularGem.find(params[:id])
    GemImporter.update_gem(@popular_gem.name)
    redirect_to @popular_gem
  end

  private
  def gem_params
    params.require(:popular_gem).permit(:name)
  end
end