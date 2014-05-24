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
    heart(stevepm, faraday)
    heart(stevepm, rails)
    heart(stevepm, test)
    heart(john, test)
    heart(john, rails)
    heart(adam, test)
    expect(PopularGem.top_hearted(2)).to eq([test, rails])
  end
end