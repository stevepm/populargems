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
      indexes :gh_stars, type: 'long'
      indexes :gh_forks, type: 'long'
      indexes :gh_issues, type: 'long'
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
                          script: "_score * (doc['total_downloads'].value + doc['gh_stars'].value * 400  + doc['gh_forks'].value * 150 + doc['gh_issues'].value * 300) / 2**3.1"
                        }
                      ],
                      score_mode: "sum"
                    }}
                  ]
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

    def most_active(limit = nil)
      where("score > ?", 0).order(score: :desc).limit(limit)
    end

    def recently_liked(limit = nil)
      all.joins('inner join votes v on popular_gems.id = v.votable_id').where(v: {vote_flag: true, votable_type: 'PopularGem'}).group("popular_gems.id").order('max(v.updated_at) DESC').limit(limit)
    end

    def featured
      where(featured: true).order(updated_at: :desc)
    end

  end

  def calculate_score
    score = ((self.gh_stars.to_f*3.0) + (self.gh_forks.to_f*10.0)
    +(self.cached_votes_up.to_f * 20.0) + (self.gh_issues.to_f * 15.0) +
      (self.total_downloads.to_f/100000.0))
    if self.gh_updated_at
      if self.gh_updated_at > 1.week.ago
        score += 1000
      elsif self.gh_updated_at > 2.weeks.ago
        score += 500
      elsif self.gh_updated_at > 3.weeks.ago
        score += 250
      elsif self.gh_updated_at > 4.weeks.ago
        score += 100
      end
    end
    score
  end
end