module CreateHeartHelper
  def heart(user, popular_gem)
    Heart.create(user: user, popular_gem: popular_gem)
  end
end