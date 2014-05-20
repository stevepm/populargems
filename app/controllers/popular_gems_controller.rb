class PopularGemsController < ApplicationController
  def index
    @popular_gem = PopularGem.new
    @gems = PopularGem.order(total_downloads: :desc).paginate_gems(params[:page])
  end

  def create
    @popular_gem = PopularGem.create(gem_params)
    if @popular_gem.valid?
      redirect_to @popular_gem
    elsif @popular_gem.errors[:name].first == "has already been taken"
      @popular_gem = PopularGem.find_by_name(@popular_gem.name)
      redirect_to @popular_gem
    else
      @gems = PopularGem.order(total_downloads: :desc).paginate_gems params[:page]
      flash[:notice] = "That gem does not exist"
      render :index
    end
  end

  def show
    @popular_gem = PopularGem.find(params[:id])
    @comments = @popular_gem.comments.all
    @comment = Comment.new
  end

  def edit
    @popular_gem = PopularGem.find(params[:id])
    @popular_gem.update(name: @popular_gem.name)
    render :show
  end

  private
  def gem_params
    params.require(:popular_gem).permit(:name)
  end
end