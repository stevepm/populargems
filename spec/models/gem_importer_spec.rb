require 'spec_helper'

describe GemImporter do
  it 'adds all details of a gem to db, given a name' do
    VCR.use_cassette('models/gem_importer/create_gem') do
      GemImporter.seed_db('faraday')
      faraday = PopularGem.find_by_name('faraday')
      expect(faraday.name).to eq('faraday')
      expect(faraday.total_downloads).to eq(9278401)
      expect(faraday.version).to eq('0.9.0')
      expect(faraday.version_downloads).to eq(1010668)
      expect(faraday.description).to eq('HTTP/REST API client library.')
      expect(faraday.url).to eq('http://rubygems.org/gems/faraday')
      expect(faraday.source_code_url).to eq(nil)
      expect(faraday.project_url).to eq("https://github.com/lostisland/faraday")
      expect(faraday.gh_issues).to eq(54)
      expect(faraday.gh_stars).to eq(1962)
      expect(faraday.gh_updated_at).to eq('Fri, 06 Jun 2014 12:17:51 UTC +00:00')
      expect(faraday.gh_forks).to eq(274)
    end
  end

  it 'returns an error if the gem is not found' do
    VCR.use_cassette('models/gem_importer/create_gem_error') do
      not_a_gem = GemImporter.seed_db('jkawkjdkjawd')
      expect(not_a_gem).to eq(false)
    end
  end

  it 'can update the gem information' do
    VCR.use_cassette('models/gem_importer/update_gem') do
      GemImporter.seed_db('rails')
      rails = PopularGem.find_by_name('rails')
      expect(rails.total_downloads).to eq(36508701)
      VCR.use_cassette('models/gem_importer/update_gem_again') do
        GemImporter.update_gem('rails')
        rails.reload
        expect(rails.total_downloads).to eq(36508764)
      end
    end
  end
end