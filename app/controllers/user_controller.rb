class UserController < ApplicationController
  def show
    @user = User.friendly.find(params[:id])
    @loved_gems = Kaminari.paginate_array(@user.votes.up.for_type(PopularGem).votables).page(params[:page])
    meta_tag_setter(
      "#{@user.name}",
      "#{@user.name}'s profile'",
      "Ruby, gems, ruby gems, rails, #{@user.name}",
      true
    )
  end
end