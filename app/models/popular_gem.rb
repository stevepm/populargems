class PopularGem < ActiveRecord::Base
  has_many :comments
  has_many :hearts
  validates :name, uniqueness: true

  def self.top_downloaded(limit = nil)
    order(total_downloads: :desc).limit(limit)
  end

  def self.top_hearted(limit = nil)
    select("popular_gems.id, count(popular_gems.id) AS heart_count").
      joins(:hearts).group("popular_gems.id").
      order("heart_count DESC").
      limit(limit).map{|id| PopularGem.find(id)}
  end

end
