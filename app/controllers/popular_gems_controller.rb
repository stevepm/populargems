class PopularGemsController < ApplicationController
  def index
    @featured_gems = PopularGem.featured
    set_meta_tags :title => 'Ruby Gem discovery engine',
                  :description => 'Discover the most downloaded and most loved Ruby Gems',
                  :keywords => 'Ruby, gems, ruby gems, rails, top ruby gems, top rubygems,
 top rails gems, popular rubygems, popular ruby gems, popular gems, top gems, popular rails gems,
list of top gems, list of top ruby gems, list of top rubygems, list of top rails gems'
  end

  def show
    @gem = PopularGem.friendly.find(params[:id])
    set_meta_tags :title => "#{@gem.name}",
                  :description => "#{@gem.description}",
                  :keywords => "Ruby, gems, ruby gems, rails, #{@gem.name}, #{@gem.name} gem",
                  :reverse => true
  end

  def edit
    gem = PopularGem.friendly.find(params[:id])
    PopularGem.without_timestamps do
      GemImporter.update_gem(gem.name)
    end
    updated_gem = PopularGem.friendly.find(params[:id])
    render json: {gem: updated_gem}
  end

  def most_downloaded
    @top_downloaded_gems = PopularGem.top_downloaded.pagination(params[:page])
    set_meta_tags :title => 'Most downloaded ruby gems',
                  :description => 'Discover the most downloaded ruby gems',
                  :keywords => 'Ruby, gems, ruby gems, rails',
                  :reverse => true
  end

  def most_active
    @most_active_gems = PopularGem.most_active.pagination(params[:page])
    set_meta_tags :title => 'Most active ruby gems',
                  :description => 'Discover the most active ruby gems',
                  :keywords => 'Ruby, gems, ruby gems, rails',
                  :reverse => true
  end

  def most_hearted
    @top_hearted_gems = PopularGem.top_hearted.pagination(params[:page])
    set_meta_tags :title => 'Most loved ruby gems',
                  :description => 'Discover the most loved ruby gems',
                  :keywords => 'Ruby, gems, ruby gems, rails',
                  :reverse => true
  end

  def like
    gem = PopularGem.friendly.find(params[:id])

    PopularGem.without_timestamps do
      if current_user.liked?(gem)
        current_user.dislikes gem
        current_user.subtract_points(1)
      else
        current_user.likes gem
        current_user.add_points(1)
      end
    end

    render json: {gem: gem, likes: current_user.liked?(gem)}
  end

  def likes
    @gem = PopularGem.friendly.find(params[:id])
    @users = @gem.votes_for.up.by_type(User).voters
    set_meta_tags :title => "#{@gem.name} likes",
                  :description => "Users that like #{@gem.name}",
                  :keywords => "Ruby, gems, ruby gems, rails, #{@gem.name}, #{@gem.name} gem",
                  :reverse => true
  end

  private
  def gem_params
    params.require(:popular_gem).permit(:name)
  end
end
