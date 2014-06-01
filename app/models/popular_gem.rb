class PopularGem < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :comments
  acts_as_votable
  validates :name, uniqueness: true

  settings index: {number_of_shards: 1} do
    mappings dynamic: 'false' do
      indexes :name, analyzer: 'english', index_options: 'offsets'
      indexes :description, analyzer: 'english', index_options: 'offsets'
      indexes :total_downloads, type: 'long'
    end
  end

  class << self
    attr_reader :downloaded

    def initialize
      @downloaded = []
    end

    def search(query)
      __elasticsearch__.search(
        {
          from: 0,
          size: 150,
          query: {
            filtered: {
              query: {
                bool: {
                  should: [
                    function_score: {
                      query: {
                        multi_match: {
                          query: query,
                          fields: ['name^3', 'description'],
                          type: "phrase_prefix"
                        }
                      },
                      functions: [
                        script_score: {
                          script: "_score * doc['total_downloads'].value / 2**3.1"
                        }
                      ],
                      score_mode: "sum"
                    }
                  ]
                }
              },
              filter: {
                range: {
                  total_downloads: {
                    from: 1000
                  }
                }
              }
            }
          }
        }
      )
    end

    def top_downloaded(limit = nil)
      @downloaded = order(total_downloads: :desc).limit(limit)
    end

    def top_hearted(limit = nil)
      @downloaded = order(cached_votes_score: :desc).limit(limit)
    end
  end
end