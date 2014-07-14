class SearchesController < ApplicationController
  def show
    gem_name = params[:gem_name]
    response = PopularGem.search(gem_name)
    @results = response.page(params[:page]).records
    meta_tag_setter(
      "#{gem_name}",
      "Search for #{gem_name}",
      "Ruby, gems, ruby gems, rails, #{gem_name}, #{gem_name} gem",
      true
    )
  end
end