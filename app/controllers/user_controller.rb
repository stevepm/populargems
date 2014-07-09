class UserController < ApplicationController
  def show
    @user = User.friendly.find(params[:id])
    @loved_gems = Kaminari.paginate_array(@user.votes.up.for_type(PopularGem).votables).page(params[:page])
    set_meta_tags :title => "#{@user.name}",
                  :description => "#{@user.name}'s profile'",
                  :keywords => "Ruby, gems, ruby gems, rails, #{@user.name}",
                  :reverse => true
  end
end