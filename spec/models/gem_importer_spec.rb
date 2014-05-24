require 'spec_helper'

describe GemImporter do
  it 'adds all details of a gem to db, given a name' do
    VCR.use_cassette('models/gem_importer/create_gem') do
      GemImporter.seed_db('faraday')
      faraday = PopularGem.find_by_name('faraday')
      expect(faraday.name).to eq('faraday')
      expect(faraday.total_downloads).to eq(8765225)
      expect(faraday.version).to eq('0.9.0')
      expect(faraday.version_downloads).to eq(709933)
      expect(faraday.description).to eq('HTTP/REST API client library.')
      expect(faraday.url).to eq('http://rubygems.org/gems/faraday')
    end
  end

  it 'returns an error if the gem is not found' do
    VCR.use_cassette('models/gem_importer/create_gem_error') do
      not_a_gem = GemImporter.seed_db('jkawkjdkjawd')
      expect(not_a_gem).to eq(nil)
    end
  end

  it 'can update the gem information' do
    VCR.use_cassette('models/gem_importer/update_gem') do
      GemImporter.seed_db('rails')
      rails = PopularGem.find_by_name('rails')
      expect(rails.total_downloads).to eq(35467693)
      VCR.use_cassette('models/gem_importer/update_gem_again') do
        GemImporter.update_gem('rails')
        rails.reload
        expect(rails.total_downloads).to eq(35349156)
      end
    end
  end
end