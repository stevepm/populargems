require 'spec_helper'

describe GithubInfo do
  it 'grabs a bunch of information' do
    VCR.use_cassette('/models/github_info/meta-tags') do
      faraday = mock_gem

      puts faraday.project_url

      faraday_info = GithubInfo.gather(faraday)
      expect(faraday_info).to eq({forks: 274, issues: 53, stars: 1955, updated_at: "2014-06-20T02:27:37Z"})
    end
  end
end