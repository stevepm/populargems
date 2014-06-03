require 'spec_helper'

describe Comment do
  let (:text) { 'lorem ipsum <a href=\"https://gist.github.com/stevepm/4562475bd1f4d57e7f9f\" target=\"_blank\" rel=\"nofollow\">https://gist.github.com/stevepm/4562475bd1f4d57e7f9f</a>' }
  let (:link) { Comment.body_links(text) }
  it 'can find links in a long string' do
    expect(link).to eq(['<a href=\"https://gist.github.com/stevepm/4562475bd1f4d57e7f9f\" target=\"_blank\" rel=\"nofollow\">https://gist.github.com/stevepm/4562475bd1f4d57e7f9f</a>'])
  end

  it 'can find a url from a link' do
    expect(Comment.url_for(link.first).first.first).to eq('https://gist.github.com/stevepm/4562475bd1f4d57e7f9f')
  end

  it 'can replace url in body' do
    VCR.use_cassette('models/comment/check_embedly') do
      expect(Comment.check_embedly(text)).to eq(
                                               "lorem ipsum <script src=\"https://gist.github.com/stevepm/4562475bd1f4d57e7f9f.js\"></script>"
                                             )
    end
  end
end