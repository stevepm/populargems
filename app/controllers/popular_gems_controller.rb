class PopularGemsController < ApplicationController
  def index
    @top_downloaded_gems = PopularGem.top_downloaded(10)
    @top_hearted_gems = PopularGem.order('cached_votes_score').reverse[0..9]
    set_meta_tags :title => 'Home',
                  :description => 'Discover the most downloaded and most loved Ruby Gems',
                  :keywords => 'Ruby, gems, ruby gems, rails'
  end

  def show
    @gem = PopularGem.friendly.find(params[:id])
    @comments = @gem.comments.order('cached_votes_score').reverse
    @comment = Comment.new
    set_meta_tags :title => "#{@gem.name}",
                  :description => "#{@gem.description}",
                  :keywords => "Ruby, gems, ruby gems, rails, #{@gem.name}"
  end

  def edit
    gem = PopularGem.friendly.find(params[:id])
    GemImporter.update_gem(gem.name)
    redirect_to gem
  end

  def most_downloaded
    @gems = PopularGem.top_downloaded.pagination(params[:page])
    set_meta_tags :title => 'Most downloaded',
                  :description => 'Discover the most downloaded Ruby Gems',
                  :keywords => 'Ruby, gems, ruby gems, rails'
  end

  def most_hearted
    @gems = Kaminari.paginate_array(PopularGem.order('cached_votes_score').reverse).page(params[:page]).per(10)
    set_meta_tags :title => 'Most loved',
                  :description => 'Discover the most loved Ruby Gems',
                  :keywords => 'Ruby, gems, ruby gems, rails'
  end

  def like
    user = User.find(params[:user_id])
    gem = PopularGem.friendly.find(params[:id])
    user.likes gem
    redirect_to :back
  end

  def unlike
    user = User.find(params[:user_id])
    gem = PopularGem.friendly.find(params[:id])
    user.dislikes gem
    redirect_to :back
  end

  def likes
    @gem = PopularGem.friendly.find(params[:id])
    @users = @gem.votes_for.up.by_type(User).voters
    set_meta_tags :title => "#{@gem.name} likes",
                  :description => "Users that like #{@gem.name}",
                  :keywords => "Ruby, gems, ruby gems, rails, #{@gem.name}"
  end

  private
  def gem_params
    params.require(:popular_gem).permit(:name)
  end
end