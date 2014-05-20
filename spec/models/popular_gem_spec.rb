require 'spec_helper'

describe PopularGem do
  let (:rails) {PopularGem.create(name: 'rails')}

  it 'adds all details of a gem to db, given a name' do
    VCR.use_cassette('models/popular_gems/create_gem') do
      faraday = PopularGem.create(name: 'faraday')
      expect(faraday.name).to eq('faraday')
      expect(faraday.total_downloads).to eq(8658165)
      expect(faraday.version).to eq('0.9.0')
      expect(faraday.version_downloads).to eq(652503)
      expect(faraday.description).to eq('HTTP/REST API client library.')
      expect(faraday.url).to eq('http://rubygems.org/gems/faraday')
    end
  end

  it 'returns an error if the gem is not found' do
    VCR.use_cassette('models/popular_gems/create_gem_error') do
      test = PopularGem.new(name: 'jkawkjdkjawd')
      expect(test.valid?).to be(false)
    end
  end
end