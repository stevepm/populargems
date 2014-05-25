require 'spec_helper'

describe PopularGem do
  let (:faraday) {mock_gem('faraday', 9000)}
  let (:rails) {mock_gem('rails', 8000)}
  let (:test) {mock_gem('test', 7000)}
  let (:stevepm) {mock_user}
  let (:john) {mock_user('john')}
  let (:adam) {mock_user('adam')}
  it 'can return the top downloaded gems in an array' do
    expect(PopularGem.top_downloaded(2)).to eq([faraday, rails])
  end

  it 'can return the top hearted gems in an array' do
    stevepm.likes faraday
    stevepm.likes rails
    stevepm.likes test
    john.likes test
    john.likes rails
    adam.likes test
    expect(PopularGem.order('cached_votes_score').reverse[0..1]).to eq([test, rails])
  end
end