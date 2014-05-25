class PopularGem < ActiveRecord::Base
  has_many :comments
  acts_as_votable
  validates :name, uniqueness: true

  def self.top_downloaded(limit = nil)
    order(total_downloads: :desc).limit(limit)
  end
end
