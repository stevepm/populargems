class PopularGem < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :comments
  acts_as_votable
  validates :name, uniqueness: true

  def self.search(query)
    __elasticsearch__.search({from: 0, size: 150, query: {
      bool: {
        should: [
          multi_match: {
            query: query,
            fields: ['name^3', 'description']
          }
        ]
      },
      filtered: {
        filter: {
          range: {
            total_downloads: {
              from: 1000
            }
          }
        }
      }}})
  end

  def self.top_downloaded(limit = nil)
    order(total_downloads: :desc).limit(limit)
  end
end
