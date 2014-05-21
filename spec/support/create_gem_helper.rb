module CreateGemHelper
  def mock_gem(gem = 'faraday')
    GemImporter.seed_db(gem)
  end
end