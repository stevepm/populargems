class PopularGem < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  extend FriendlyId
  friendly_id :name, use: :slugged
  acts_as_votable
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

  def set_score

    score = ((gh_star_score(self.gh_stars.to_f)) + (gh_fork_score(self.gh_forks.to_f))
    +(self.cached_votes_up.to_f * 20.0) + (self.gh_issues.to_f * 5.5) +
      (total_downloads_score(self.total_downloads.to_f)))
    if self.gh_updated_at
      if recently_updated?(1)
        score*=1.5
      elsif recently_updated?(2)
        score*=1.25
      elsif recently_updated?(3)
        score*=1.15
      elsif recently_updated?(4)
        score*=1.1
      end
    end
    self.update(score: score)
  end

  def recently_updated?(week_number)
    if self.gh_updated_at
      self.gh_updated_at > week_number.week.ago && self.updated_at > week_number.week.ago
    else
      self.updated_at > week_number.week.ago
    end
  end

  private

  def gh_star_score(stars)
    case stars
      when stars > 10000
        score = stars*0.9
      when 3000..9999
        score = stars
      when 2000..2999
        score = stars * 1.1
      when 1000..1999
        score = stars *1.2
      when 700..999
        score = stars * 1.35
      when 500..699
        score = stars * 1.7
      when 300..499
        score = stars * 2
      else
        score = stars * 3
    end
    score
  end

  def gh_fork_score(forks)
    case forks
      when forks > 3000
        score = forks*0.9
      when 2000..2999
        score = forks
      when 1000..1999
        score = forks * 1.1
      when 500..999
        score = forks *1.5
      when 300..499
        score = forks * 2
      else
        score = forks * 3
    end
    score
  end

  def total_downloads_score(total_downloads)
    case total_downloads
      when total_downloads > 15000000
        score = total_downloads*0.01
      when 10000000..14999999
        score = total_downloads*0.02
      when 5000000..9999999
        score = total_downloads * 0.04
      when 2000000..4999999
        score = total_downloads *0.07
      when 1000000..1999999
        score = total_downloads * 0.1
      else
        score = total_downloads * 1
    end
    score
  end

end