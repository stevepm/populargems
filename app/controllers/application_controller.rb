class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  before_action :sidebar

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session[:user_id] = nil
  end

  def current_user
    @current_user = User.find(session[:user_id]) if logged_in?
  end

  def logged_in?
    !logged_in_user_id.nil?
  end

  def logged_in_user_id
    session[:user_id]
  end

  def sidebar
    @recently_liked = PopularGem.recently_liked(10)
    @recently_updated = PopularGem.all.limit(10).order(updated_at: :desc)
  end
end
