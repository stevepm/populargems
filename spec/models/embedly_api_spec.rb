require 'spec_helper'

describe EmbedlyApi do
  it 'can return embedly output from a github url' do
    VCR.use_cassette('models/embedly_api/github_output') do
      input = 'https://gist.github.com/stevepm/4562475bd1f4d57e7f9f'
      output = EmbedlyApi.new(input).output
      expect(output).to eq("<script src=\"https://gist.github.com/stevepm/4562475bd1f4d57e7f9f.js\"></script>")
    end
  end
end