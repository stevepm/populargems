class PopularGem < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  extend FriendlyId
  friendly_id :name, use: :slugged
  acts_as_votable
  acts_as_commentable
  validates :name, uniqueness: true

  settings index: {number_of_shards: 1} do
    mappings dynamic: 'false' do
      indexes :name, analyzer: 'standard', index_options: 'offsets'
      indexes :description, analyzer: 'standard', index_options: 'offsets'
      indexes :total_downloads, type: 'long'
    end
  end

  class << self

    def search(query)
      __elasticsearch__.search(
        {
          from: 0,
          size: 50,
          query: {
            filtered: {
              query: {
                bool: {
                  should: [
                    {function_score: {
                      query: {
                        multi_match: {
                          query: query,
                          fields: ['name', 'description'],
                          type: "phrase"
                        }
                      },
                      functions: [
                        script_score: {
                          script: "_score * doc['total_downloads'].value / 2**3.1"
                        }
                      ],
                      score_mode: "sum"
                    }},
                    {term: {name:
                              {value: query,
                               boost: 2.0}}
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
      order(total_downloads: :desc).limit(limit)
    end

    def top_hearted(limit = nil)
      order(cached_votes_score: :desc).limit(limit)
    end
  end
end