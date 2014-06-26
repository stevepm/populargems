require 'spec_helper'

describe GithubInfo do
  it 'grabs a bunch of information' do
    VCR.use_cassette('/models/github_info/meta-tags') do
      faraday = mock_gem
      faraday_info = GithubInfo.gather(faraday.url, faraday.project_url, faraday.source_code_url)
      expect(faraday_info).to eq({forks: 274, issues: 54, stars: 1962, updated_at: "2014-06-06T12:17:51Z"})
      faraday.update(
        gh_forks: faraday_info[:forks],
        gh_issues: faraday_info[:issues],
        gh_stars: faraday_info[:stars],
        gh_updated_at: faraday_info[:updated_at]
      )
      expect(faraday.recently_updated?(1)).to eq(false)
      expect(faraday.recently_updated?(3)).to eq(true)
    end
  end
end