class Comment < ActiveRecord::Base
  acts_as_nested_set :scope => [:commentable_id, :commentable_type]
  acts_as_votable
  validates :body, :presence => true
  validates :user, :presence => true


  belongs_to :commentable, :polymorphic => true

  # NOTE: Comments belong to a user
  belongs_to :user

  # Helper class method that allows you to build a comment
  # by passing a commentable object, a user_id, and comment text
  # example in readme
  def self.create_from_gem_page(params)
    create(
      :commentable => PopularGem.find(params[:popular_gem]),
      :body        => "<blockquote>#{ConvertFromMarkdown.new.render(params[:body])}</blockquote>",
      :user_id     => params[:user]
    )
  end

  def self.create_from_gist_youtube(body, user_id, commentable)
    create(
      :commentable => commentable,
      :body        => body,
      :user_id     => user_id
    )
  end

  def self.create_from_imgur(body, user_id, commentable)
    create(
      :commentable => commentable,
      :body        => body,
      :user_id     => user_id
    )
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
    all.sort_by(&:created_at).map(&:commentable_id).uniq[0..9].map {|id| PopularGem.find(id)}
  end
end
