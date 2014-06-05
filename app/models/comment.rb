class Comment < ActiveRecord::Base
  acts_as_nested_set :scope => [:commentable_id, :commentable_type]
  acts_as_votable
  validates :body, :presence => true
  validates :user, :presence => true


  belongs_to :commentable, :polymorphic => true

  belongs_to :user

  def self.create_from_gem_page(params)
    body = check_embedly(params[:body])
    create(
      :commentable => PopularGem.find(params[:popular_gem]),
      :body => "<blockquote>#{ConvertFromMarkdown.new.render(body)}</blockquote>",
      :user_id => params[:user]
    )
  end

  def self.check_embedly(body)
    body_links(body).each do |link|
      body.sub!(link, EmbedlyApi.new(url_for(link).first.first).output)
    end
    body
  end

  def self.body_links(body)
    body.scan(/<a href=.*?<\/a>/)
  end

  def self.url_for(link)
    link.scan(/<a href="(.*?)"/)
  end

  #helper method to check if a comment has children
  def has_children?
    self.children.any?
  end

  # Helper class method to lookup all comments assigned
  # to all commentable types for a given user.
  scope :find_comments_by_user, lambda { |user|
    where(:user_id => user.id).order('created_at DESC')
  }

  # Helper class method to look up all comments for
  # commentable class name and commentable id.
  scope :find_comments_for_commentable, lambda { |commentable_str, commentable_id|
    where(:commentable_type => commentable_str.to_s, :commentable_id => commentable_id).order('created_at DESC')
  }

  # Helper class method to look up a commentable object
  # given the commentable class name and id
  def self.find_commentable(commentable_str, commentable_id)
    commentable_str.constantize.find(commentable_id)
  end

  def self.recent_comments
    all.sort_by(&:created_at).map(&:commentable_id).uniq[0..9].map { |id| PopularGem.find(id) }.reverse
  end
end
