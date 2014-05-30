class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :popular_gem
  acts_as_votable

  validates :body, :presence => true
  validates :user, :presence => true
  validates :popular_gem, :presence => true

  def self.create_from_gem_page(params)
    create do |comment|
      comment.body = "<blockquote>#{ConvertFromMarkdown.new.render(params[:body])}</blockquote>"
      comment.user = User.find(params[:user])
      comment.popular_gem = PopularGem.find(params[:popular_gem])
    end
  end

  def self.recent_comments
    all.sort_by(&:created_at).map(&:popular_gem).uniq[0..9]
  end
end
