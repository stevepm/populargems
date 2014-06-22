module CreateGemHelper
  def mock_gem(name = 'faraday', downloads = '12345')
    PopularGem.create(name: name, total_downloads: downloads, version: '1.2', version_downloads: 1234, url: 'google.com', project_url: 'github.com/lostisland/faraday', description: 'search engine')
  end
end