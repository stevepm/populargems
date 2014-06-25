require 'spec_helper'

describe GithubInfo do
  it 'grabs a bunch of information' do
    VCR.use_cassette('/models/github_info/meta-tags') do
      faraday = mock_gem
      faraday_info = GithubInfo.gather(faraday.url, faraday.project_url, faraday.source_code_url)
      expect(faraday_info).to eq({forks: 274, issues: 54, stars: 1962, updated_at: "2014-06-06T12:17:51Z"})
    end
  end
end